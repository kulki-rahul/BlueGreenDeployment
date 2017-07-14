stage 'Checkout'
node {
   git 'https://github.com/kulki-rahul/BlueGreenDeployment.git' // Checks out example votiung app repository
     }
  stage 'Build'
  node {
		bat 'nuget restore BlueGreenDeploymentDemo.sln'
		bat '"C:/Program Files (x86)/Microsoft Visual Studio/2017/BuildTools/MSBuild/15.0/Bin/msbuild.exe" @"BlueGreenDeployment/BlueGreenDeploymentDemo.csproj" '
	   }
	