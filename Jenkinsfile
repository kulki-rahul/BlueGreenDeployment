stage 'Checkout'
node {
   git 'https://github.com/kulki-rahul/BlueGreenDeployment.git' // Checks out example votiung app repository
     }
   stage 'Docker Builds'
   docker.withRegistry('https://rkulkarnidevopsdemo.azurecr.io/', 'private-login') {
        parallel(
            "Build Website":{def myEnv = docker.build('rkulkarnidevopsdemo.azurecr.io/webapplication2:v1', 'web').push('latest')},
            )
    }
	stage 'Kubernetes Deployment'
    	sh 'kubectl apply -f docker-compose-v1.yml'   
}