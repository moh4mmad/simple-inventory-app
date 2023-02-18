aws ecr get-login-password --region ${AWS_DEFAULT_REGION} | docker login --username AWS --password-stdin ${REPOSITORY_URI}
docker build -t ${IMAGE_REPO_NAME}:${IMAGE_TAG} .
docker tag ${IMAGE_REPO_NAME}:${IMAGE_TAG} ${REPOSITORY_URI}:${IMAGE_TAG}
docker push ${REPOSITORY_URI}:${IMAGE_TAG}