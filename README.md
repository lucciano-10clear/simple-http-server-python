## Create an ECR repository:

aws ecr create-repository --repository-name my-http-server


Authenticate Docker to ECR:

aws ecr get-login-password --region <your-region> \
| docker login --username AWS --password-stdin <aws_account_id>.dkr.ecr.<region>.amazonaws.com


Build and push image:

docker build -t my-http-server .
docker tag my-http-server:latest <aws_account_id>.dkr.ecr.<region>.amazonaws.com/my-http-server:latest
docker push <aws_account_id>.dkr.ecr.<region>.amazonaws.com/my-http-server:latest

## Create the ECS Infrastructure

Option A: Using AWS Console (Quickest to test)

Go to ECS → Clusters → Create Cluster → Networking only (Fargate)

Name it: my-cluster

Go to Task Definitions → Create new task definition

Launch type: Fargate

Container:

Image: <ECR-Image-URI>

Port mappings: 8080

CPU: 256

Memory: 512

Task Role: ecsTaskExecutionRole (auto-created if you don’t have one)

Create Service:

Launch type: Fargate

Desired tasks: 1

Network: choose VPC + public subnets

Enable Application Load Balancer

Listener port: 80

Target group: new (health check path /)

Wait for service to reach RUNNING and HEALTHY state.
Your load balancer’s DNS name now serves your HTTP response.

