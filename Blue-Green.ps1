
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

$podNamesArray = kubectl get pods -o "name"
$podNames =  $podNamesArray.split(' ')

$blueGreen = 0;
$bluePodName = ""
$greenPodName = ""

if($podNames.Count -gt 1)
{
    $blueGreen = 1;
}

for($count=0; $count -le $podNames.Count - 1;$count++)
{
    $names = $podNames[$count].tostring().split('/');
    $name = $names[1].split('-');
    if($name -contains "blue")
    {
        $bluePodName = $podNames[$count].tostring().split('/')[1]
        if($blueGreen -eq 0)
        {
            kubectl expose pods $bluePodName --port=80 --type=LoadBalancer
        }
    }
    elseif ($name -contains "green")
    {
        $greenPodName = $podNames[$count].tostring().split('/')[1]
        kubectl expose pods $greenPodName --port=80 --type=LoadBalancer
    }
}

$countSvcCreation = 1;

do
{

Sleep 15

$svcStatus = kubectl get svc
$podName = ""
if($blueGreen -eq 1)
{
    $podName = $greenPodName;
}
else
{
    $podName = $bluePodName;
}

for($countofSvc = 1; $countofSvc -lt $svcStatus.count; $countofSvc++)
{
   if($svcStatus[$countofSvc].split(' ')[0].tostring() -eq $podName)
   {
        if($svcStatus[$countofSvc].split(' ') -notcontains "<pending>")
        {
            $st = $svcStatus[$countofSvc].split(' ')
            $k=$st | ? {$_}
            az network application-gateway address-pool update --gateway-name rkulkarni -n appGatewayBackendPool -g devOpsDemo --servers $k[2].tostring()
            $countSvcCreation = 2;
            break;
        }
   }
}

 if($countSvcCreation = 2)
   {
        break;
   }

}while($countSvcCreation = 1)



