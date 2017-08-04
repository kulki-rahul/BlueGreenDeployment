
do
{

Sleep 15

$countPodsCreation = 1

$podSta = kubectl get pods

    if($podSta.Count -gt 0)
    {
        $podStatus = kubectl get pods -o jsonpath="'{.items[*].status.containerStatuses[*].state}'"
        $podState = $podStatus.tostring().split(' ')
        if($podState -notcontains "'map[waiting:map[reason:ContainerCreating]]'")
        {
	        $countPodsCreation = 2
	        break	
        }
    }
}
while($countPodsCreation = 1)

$PodList = kubectl get pods -o jsonpath="{.items[*].status.containerStatuses[*].image}"
$podIndex =0;
foreach($pod in $PodList.Split(' '))
{
  
  if($pod -eq  [Environment]::GetEnvironmentVariable("FullDeploymentName","User"))
  {
    $PodNameList = kubectl get pods -o jsonpath="{.items[*].metadata.name}"
    $PodNames = $PodNameList.Split(' ')
    $podName = $PodNames[$podIndex]

  }
  $podIndex ++
}



kubectl expose pods $podName --port=80 --type=LoadBalancer

$countSvcCreation = 1;

do
{

Sleep 15

$svcStatus = kubectl get svc

if($svcStatus.Count -gt 0)
{

    for($countofSvc = 1; $countofSvc -lt $svcStatus.count; $countofSvc++)
    {
       if($svcStatus[$countofSvc].split(' ')[0].tostring() -eq $podName)
       {
            if($svcStatus[$countofSvc].split(' ') -notcontains "<pending>")
            {
                $st = $svcStatus[$countofSvc].split(' ')
                $k=$st | ? {$_}
                [Environment]::SetEnvironmentVariable("DeploymentIPAddress", $k[2].tostring(), "User")                
                $countSvcCreation = 2;
                break;
            }
       }
    }

     if($countSvcCreation -ge 2)
       {
            break;
       }
 }

}while($countSvcCreation = 1)



