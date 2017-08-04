
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

$PodList = kubectl get pods -o jsonpath="{.items[*].status.containerStatuses[*].image},{.items[*].metadata.name}"
foreach($pod in $PodList)
{
  if($pod.Split(',')[0] -eq  $env:FullDeploymentName)
  {
    $podName = $pod.Split(',')[1]
  }
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
		$env:DeploymentIPAddress = $k[2].tostring()                
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



