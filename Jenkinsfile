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
        IMAGE_TAG="${env.BUILD_ID}"
        REPOSITORY_URI = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}"
        registryCredential = "aws-credential"
        workdir = "./backend"
        BRANCH_NAME = "${GIT_BRANCH.split("/")[1]}"
    }
   
    stages {
   
      // Building image & Pushing to ECR
      stage('Building image & Pushing to ECR') {
        when {
          expression {
            BRANCH_NAME == 'backend' || BRANCH_NAME == 'frontend'
          }
        }
        steps {
            script {
              if(BRANCH_NAME == 'frontend') {
                env.IMAGE_TAG = "${env.BUILD_ID}"
                env.SERVICE_NAME = "INVENTORY-APP-FRONTEND-TASK"
                env.TASK_DEFINITION_NAME = "INVENTORY-APP-FRONTEND"
                env.workdir = "./frontend"
              }
              docker.withRegistry("https://" + REPOSITORY_URI, "ecr:${AWS_DEFAULT_REGION}:" + registryCredential)
              {
                dir(workdir) {
                  //build image
                  dockerImage = docker.build("${IMAGE_REPO_NAME}:${IMAGE_TAG}")
                  //push image
                  dockerImage.push()
                }
              }
            }
          }
      }
      
      // deploying to AWS ECS
      stage('Deploy') {
        when {
          expression {
            BRANCH_NAME == 'backend' || BRANCH_NAME == 'frontend'
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