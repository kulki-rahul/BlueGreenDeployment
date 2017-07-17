stage 'Checkout'
node {
   git 'https://github.com/kulki-rahul/BlueGreenDeployment.git' // Checks out example votiung app repository
     }
  stage 'Deploy'
  node {
	  bat 'mklink "C:/Program Files (x86)/Jenkins/workspace/bluegreen/kubectl.exe" "C:/Program Files (x86)/kubectl.exe"'
	  bat 'kubectl get pods" '
  }
	
