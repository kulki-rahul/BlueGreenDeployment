
sleep 5

$list = az acr repository show-tags -n rkulkarnidevopsdemo --repository bluegreendeploymentdemo --password +++/==qh9vT+L=baPyO/+Btnj=5WExk/ --resource-group devOpsDemo --username RkulkarnidevOpsdemo -o table
$list = $list -replace 'v',''
$count = 0;

$listNumber = foreach($number in $list) {
    try {
    $count ++
    if($count -gt 2)
    {
        $k = $number.Split(',')[0]

            [int]::parse($k)
        }
    }
    catch {
        Invoke-Expression -Command $k;
    }
    }

$listNumber = $listNumber | Sort-Object
$currentVersion = $listNumber[$listNumber.Count - 1]
$newVersion = $currentVersion + 1;

(Get-Content docker-compose-v1.yml).replace('[VersionNumber]', $newVersion) | Set-Content docker-compose-v1.yml
$depName = "bluegreendeploymentdemo" + $newVersion;
(Get-Content docker-compose-v1.yml).replace('[DeploymentName]', $depName) | Set-Content docker-compose-v1.yml

docker login --username=RkulkarnidevOpsDemo --password=+++/==qh9vT+L=baPyO/+Btnj=5WExk/ rkulkarnidevopsdemo.azurecr.io
$fullDeploymentName = "rkulkarnidevopsdemo.azurecr.io/bluegreendeploymentdemo:v" + $newVersion;

powershell docker tag bluegreendeploymentdemo $fullDeploymentName
powershell docker push $fullDeploymentName

[Environment]::SetEnvironmentVariable("FullDeploymentName", $fullDeploymentName, "User")





