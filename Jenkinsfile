stage 'Checkout'
node {
   git 'https://github.com/kulki-rahul/BlueGreenDeployment.git' // Checks out example votiung app repository
     }
  stage 'Deploy'
  node {
	  bat 'powershell kubectl get pods'
  }
	
