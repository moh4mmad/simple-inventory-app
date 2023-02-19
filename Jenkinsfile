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
        workdir = "./backend"
    }
   
    stages {

    // Building Docker images
      stage('Building image') {
        when {
          expression {
            env.BRANCH_NAME == 'backend' || env.BRANCH_NAME == 'frontend'
          }
        }
        steps{
          script {
            if(env.BRANCH_NAME == 'frontend') {
              env.IMAGE_TAG = "frontend${env.BUILD_ID}"
              env.SERVICE_NAME = "INVENTORY-APP-FRONTEND-TASK"
              env.TASK_DEFINITION_NAME = "INVENTORY-APP-FRONTEND"
              env.workdir = "./frontend"
            }
          }
          dir(workdir) {
            script {
              dockerImage = docker.build "${IMAGE_REPO_NAME}:${IMAGE_TAG}"
            }
          }
        }
      }
   
    // Uploading Docker images into AWS ECR
      stage('Pushing to ECR') {
        when {
          expression {
            env.BRANCH_NAME == 'backend' || env.BRANCH_NAME == 'frontend'
          }
        }
        steps{
            script {
              docker.withRegistry("https://" + REPOSITORY_URI, "ecr:${AWS_DEFAULT_REGION}:" + registryCredential)
              {
                dockerImage.push()
              }
            }
          }
      }
      
      stage('Deploy') {
        when {
          expression {
            env.BRANCH_NAME == 'backend' || env.BRANCH_NAME == 'frontend'
          }
        }
        steps{
          withAWS(credentials: registryCredential, region: "${AWS_DEFAULT_REGION}")
          {
            script {
              sh 'chmod +x ./deploy.sh && ./deploy.sh'
            }
          }
        }
      }
      
    }
}