stage 'Checkout'
node {
   git 'https://github.com/kulki-rahul/BlueGreenDeployment.git' // Checks out example votiung app repository
     }
  stage 'Build'
		bat 'nuget restore BlueGreenDeploymentDemo.sln'
		bat "\"${tool 'MSBuild'}\" BlueGreenDeploymentDemo.sln /p:Configuration=Release /p:Platform=\"Any CPU\" /p:ProductVersion=1.0.0.${env.BUILD_NUMBER}"
	