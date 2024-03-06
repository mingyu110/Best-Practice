### Deploy Continuos Integration(CI) System in AWS ECS Fargate with Terraform

#### Background

- Jenkins cluster is built based on AWS EC2. Due to the shortage of cluster resources caused by a large number of new jobs and a large number of parallel construction tasks, more slaves have to be added to cope with it. In order to reduce the cost and obtain better resource scalability, a new Jenkins continuous integration system is constructed in AWS ECS based on Terraform. Containers have finer resource granularity, better resource elasticity and resource utilization

  ### Terminology

- [Amazon Elastic Container Service(ECS)](https://aws.amazon.com/ecs/)is a serverless orchestrator that manages container deployments on your behalf.
- [Amazon Virtual Private Cloud(VPC)](https://aws.amazon.com/vpc/)helps you define and launch AWS resources in a logically isolated virtual network.
- [AWS Fargate](https://aws.amazon.com/fargate/)is a serverless compute engine for containers that works with both Amazon Elastic Container Service (ECS) and Amazon Elastic Kubernetes (EKS).
