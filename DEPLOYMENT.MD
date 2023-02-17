## Deployment Diagram & Explanation

##### The following diagram illustrates the architecture of the deployed application:

![Logo](https://i.ibb.co/N19Fhk1/diagram.png)

## Frontend

The frontend of the application is a SPA that allows users to view and update the inventory data. It is built using React and is stored in a **CodeCommit repository**.

## Backend

The backend of the application is a RESTful API built using Node.js. It is responsible for handling the CRUD operations on the inventory data. It is stored in a **CodeCommit repository**.

## Resources Used

- Docker: The application is containerized using Docker to ensure consistency and ease of deployment.
- Elastic Container Registry (ECR): Both the frontend and backend are containerized using Docker. The Docker images are stored in an Elastic Container Registry (ECR) repository.
- Elastic Container Service (ECS): The Docker images are deployed to an Elastic Container Service (ECS) cluster. The ECS cluster is configured to automatically scale the number of tasks based on the load on the application.
- RDS: The application uses an Amazon Relational Database Service (RDS) PostgreSQL database for data storage.
- CodeCommit: CodeCommit is used as the source control repository for the frontend and backend code.
- CodePipeline: CodePipeline is used to automate the deployment of the application. It is triggered when a change is pushed to the CodeCommit repository.
- CodeBuild: CodeBuild is used to build the Docker images and push them to the ECR repository.
- VPC: The VPC is used to provide a secure and isolated network environment for the deployed resources.
- Load Balancer: The application is accessible through an Application Load Balancer (ALB) that distributes incoming traffic to the ECS cluster.
- Target Group: It contains a group of Amazon Elastic Compute Cloud (EC2) IP addresses, to which the load balancer forwards traffic.

## Scaling

The application is designed to be horizontally scalable. The ECS cluster is configured to automatically scale the number of tasks based on the load on the application. This means that if the number of users increases, the ECS cluster will automatically spin up additional tasks to handle the increased load.

The application can also scale vertically by increasing the resources (such as memory and CPU) of the running tasks. This can be done by updating the task definition with the desired resource requirements.

In addition, the RDS database can be scaled by modifying the instance type or storage size.

## Security

The following security measures are considered in the deployment:

- The application is deployed in a VPC, which provides an isolated network environment and controls access to resources through security groups and network ACLs.
- The ECR repositories are configured to require authentication to pull images.
- The ALB and the ECS tasks are placed behind a security group that allows traffic only from specific IP ranges or security groups.
- The RDS database is placed behind a security group that allows traffic only from the ECS tasks.
- The application is deployed in a multi-AZ to ensure high availability and minimize the risk of a single point of failure.

## Base Cost Calculation

The base cost of the deployment includes the following components:

- The cost of the VPC, Load Balancer, Target Group, ECS, and ECR services will depend on the number of instances and the amount of data stored.
- The cost of the CodeCommit, CodePipeline, and CodeBuild services will depend on the number of users and the amount of data stored.
- The cost of the RDS service will depend on the amount of storage and the number of read/write operations.

## Cost Estimation

The cost of the deployment will depend on the number of users and the usage of the different AWS resources.

We need to consider the following resources when estimating the cost:

- VPC: This includes the cost of creating and maintaining a virtual private cloud, including the cost of creating subnets, internet gateways, and security groups.
- Load Balancer: This includes the cost of creating and maintaining a load balancer, including the cost of data transfer and the number of requests.
- Target Group: This includes the cost of creating and maintaining a target group, including the cost of data transfer and the number of requests.
- ECS: This includes the cost of creating and maintaining a container service, including the cost of creating and running tasks, and the cost of data transfer.
- ECR: This includes the cost of creating and maintaining a container registry, including the cost of storing and managing images.
- CodeCommit: This includes the cost of creating and maintaining a source control service, including the cost of storing and managing code.
- CodePipeline: This includes the cost of creating and maintaining a continuous delivery service, including the cost of creating and running pipelines.
- CodeBuild: This includes the cost of creating and maintaining a build service, including the cost of creating and running build projects.
- RDS: This includes the cost of creating and maintaining a relational database service, including the cost of storage, data transfer, and read/write operations.

Below is a rough estimate of the cost for 100, 1000, and 10000 simultaneous app users:

- 100 users: $10/month
- 1000 users: $100/month
- 10000 users: $1000/month

The cost is calculated based on the following assumptions:

- For 100 simultaneous users: The cost would be relatively low as the number of instances and resources required would be minimal. We might expect to pay a few dollars per month for the VPC, load balancer, target group, ECS, ECR, CodeCommit, CodePipeline, CodeBuild and RDS services.
- For 1000 simultaneous users: The cost would be relatively moderate as the number of instances and resources required would increase. We might expect to pay a few hundred dollars per month for the VPC, load balancer, target group, ECS, ECR, CodeCommit, CodePipeline, CodeBuild and RDS services.
- For 10000 simultaneous users: The cost would be relatively high as the number of instances and resources required would be significant. We might expect to pay a few thousand dollars per month for the VPC, load balancer, target group, ECS, ECR, CodeCommit, CodePipeline, CodeBuild and RDS services.

_Please note that these are just estimates and the actual cost will depend on the specific requirements of the application and the amount of usage. It's recommended to monitor the cost and usage of the resources in the AWS Cost Explorer to ensure not overspending._
