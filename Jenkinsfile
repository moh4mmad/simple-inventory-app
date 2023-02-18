pipeline {
    agent any
    environment {
        AWS_ACCOUNT_ID="314543738592"
        AWS_DEFAULT_REGION="ap-southeast-2" 
        CLUSTER_NAME="inventory-app-cluster"
        SERVICE_NAME="INVENTORY-APP-BACKEND-TASK"
        TASK_DEFINITION_NAME="INVENTORY-APP-BACKEND"
        DESIRED_COUNT="1"
        IMAGE_REPO_NAME="inventory-app"
        IMAGE_TAG="backend${env.BUILD_ID}"
        REPOSITORY_URI = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}"
        registryCredential = "aws-credential"
    }
   
    stages {

      // set aws session token

      stage('Set AWS Session Token') {
        steps{
          withAWS(credentials: registryCredential, region: "${AWS_DEFAULT_REGION}") {
            script {
              //sh 'aws sts get-session-token --serial-number arn:aws:iam::314543738592:mfa/newInventoryDevice --token-code 123456 --duration-seconds 129600 > session.json'
              //def session = readJSON file: 'session.json'
              sh "export AWS_ACCESS_KEY_ID=ASIAUSPCER3QEIDA7W5Q"
              sh "export AWS_SECRET_ACCESS_KEY=ZZrQxRWx50QbvOmoLOeybOuxYsJ4YaLGmDcTWUyu"
              sh "export AWS_SESSION_TOKEN=FwoGZXIvYXdzEPL//////////wEaDET/ba6T1/9AjGhBeiKGAUZ7NQzIcQy6IN2uT/swOEt5euWHxma6MKwXcR7YASqt2k5lED3qpJacQDd7+VT/RuBI/VRmqBRP7WuRaZ5t4L7+HshIIl6FH3YK42OLKSLRX+eyyqbSszxFakerwCa2zl1DQS5qBHEAnS73JE04vhRqX0rU+C0Ta87zXTN9TCGY2ePK4e4tKKqCxJ8GMiiq9+htwgMIpmSusqlLa1gh/L2m0ZZ5Rc9e000K+GE6W3cTLOd+Kukn"
            }
          }
        }
      }

      // Building Docker images & push to ECR
      stage('Building image & push to ECR') {
        when {
          anyOf {
            branch 'backend'
            branch 'frontend'
          }
        }
        steps{
          script {
            WORKSPACE = env.BRANCH_NAME == 'backend' ? 'backend' : 'frontend'
            dir(WORKSPACE) {
              sh "aws ecr get-login-password --region ${AWS_DEFAULT_REGION} | docker login --username AWS --password-stdin ${REPOSITORY_URI}"
              sh "docker build -t ${IMAGE_REPO_NAME}:${IMAGE_TAG} ."
              sh "docker tag ${IMAGE_REPO_NAME}:${IMAGE_TAG} ${REPOSITORY_URI}:${IMAGE_TAG}"
              sh "docker push ${REPOSITORY_URI}:${IMAGE_TAG}"

            }
          }
        }
      }

      // Uploading Docker images into AWS ECR
      // stage('Pushing to ECR') {
      //   steps{  
      //       script {

      //         docker.withRegistry("https://" + REPOSITORY_URI, "ecr:${AWS_DEFAULT_REGION}:" + registryCredential)
      //         {
      //           dockerImage.push()
      //         }
      //       }
      //   }
      // }
      
      stage('Deploy') {
        steps{
          withAWS(credentials: registryCredential, region: "${AWS_DEFAULT_REGION}")
          {
            script {
              sh 'chmod +x deploy.sh && ./deploy.sh'
            }
          }
        }
      }
      
    }
}