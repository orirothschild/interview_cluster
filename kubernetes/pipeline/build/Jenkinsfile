 pipeline {
    agent any

    environment{
        PASS = credentials('registry-pass')  //dockerhub id
        DOCKER_ID = credentials('registry-id') //dockerhub pass
    }
    stages {
        stage('Build'){
            steps{
                sh './pipeline/build/build.sh'
            }
        }
         

        stage('push'){
            steps{
                sh './pipeline/push/push_to_dockerhub.sh'
            }
        }
        
        stage('Deploy'){
            steps{
                sh ''' echo "promote to spinnaker" '''
            }
            post { 
                always { 
                    cleanWs()
                }
            }
        }
    
    }
 }
