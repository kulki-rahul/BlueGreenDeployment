
$list = az acr repository show-tags -n rkulkarnidevopsdemo --repository bluegreendeploymentdemo --password +++/==qh9vT+L=baPyO/+Btnj=5WExk/ --resource-group devOpsDemo --username RkulkarnidevOpsdemo -o table
$list = $list -replace 'v',''

$listNumber = foreach($number in $list) {
    try {

    $k = $number.Split(',')[0]

        [int]::parse($k)
    }
    catch {
        Invoke-Expression -Command $k;
    }
    }

$listNumber = $listNumber | Sort-Object
$currentVersion = $listNumber[$listNumber.Count - 1]

(Get-Content docker-compose-v1.yml).replace('[VersionNumber]', $currentVersion) | Set-Content docker-compose-v1.yml
$depName = "bluegreendeploymentdemo" + $currentVersion;
(Get-Content docker-compose-v1.yml).replace('[DeploymentName]', $currentVersion) | Set-Content docker-compose-v1.yml

docker login --username=RkulkarnidevOpsDemo --password=+++/==qh9vT+L=baPyO/+Btnj=5WExk/ rkulkarnidevopsdemo.azurecr.io
$fullDeploymentName = "rkulkarnidevopsdemo.azurecr.io/bluegreendeploymentdemo:v" + $currentVersion;

powershell docker tag bluegreendeploymentdemo $fullDeploymentName
powershell docker push $fullDeploymentName
$env:FullDeploymentName = $fullDeploymentName




