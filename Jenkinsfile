stage 'Checkout'
node {
   git 'https://github.com/kulki-rahul/BlueGreenDeployment.git' // Checks out example votiung app repository
     }
  stage 'Build'
  node {
		bat 'nuget restore BlueGreenDeploymentDemo.sln'
		bat '"C:/Program Files (x86)/Microsoft Visual Studio/2017/BuildTools/MSBuild/15.0/Bin/msbuild.exe" BlueGreenDeploymentDemo.sln'
		bat 'powershell docker-compose -f "docker-compose.yml" -f "docker-compose.override.yml" -f "docker-compose.vs.release.yml" -p dockercompose2317300679 build --no-cache'
	  	bat 'powershell docker login --username=RkulkarnidevOpsDemo --password=+++/==qh9vT+L=baPyO/+Btnj=5WExk/ rkulkarnidevopsdemo.azurecr.io'
	        bat 'powershell docker tag bluegreendeploymentdemo rkulkarnidevopsdemo.azurecr.io/bluegreendeploymentdemo:v4'
	  	bat 'powershell docker push rkulkarnidevopsdemo.azurecr.io/bluegreendeploymentdemo:v4'        

	   }
stage 'Deploy'
node {
 		bat 'powershell kubectl apply -f docker-compose-v1.yml'
		bat 'powershell Blue-Green.ps1'
 	}

	
