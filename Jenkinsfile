stage 'Checkout'
node {
   git 'https://github.com/kulki-rahul/BlueGreenDeployment.git' // Checks out example votiung app repository
     }
  stage 'Build'
  node {
		bat 'nuget restore BlueGreenDeploymentDemo.sln'
		bat C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\MSBuild\15.0\Bin\MSBuild.exe BlueGreenDeploymentDemo.sln /p:Configuration=Release /p:Platform=\"Any CPU\" /p:ProductVersion=1.0.0.${env.BUILD_NUMBER}"
	   }
	