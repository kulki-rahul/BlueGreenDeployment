stage 'Checkout'
node {
   git 'https://github.com/kulki-rahul/BlueGreenDeployment.git' // Checks out example votiung app repository
     }
  stage 'Build'
  node {
		bat 'nuget restore BlueGreenDeploymentDemo.sln'
		bat '"C:/Program Files (x86)/Microsoft Visual Studio/2017/BuildTools/MSBuild/15.0/Bin/msbuild.exe" BlueGreenDeploymentDemo.sln'
	   }
 stage 'Docker Builds'
   docker.withRegistry('https://rkulkarnidevopsdemo.azurecr.io/', 'private-login') {
        parallel(
            "Build Website":{def myEnv = docker.build('rkulkarnidevopsdemo.azurecr.io/bluegreendeploymentdemo:v1').push('latest')},
            )
    }
	
