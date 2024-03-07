### Deploy Continuos Integration(CI) System in AWS ECS Fargate with Terraform

### Background

- Jenkins cluster is built based on AWS EC2. Due to the shortage of cluster resources caused by a large number of new jobs and a large number of parallel construction tasks, more slaves have to be added to cope with it. In order to reduce the cost and obtain better resource scalability, a new Jenkins continuous integration system is constructed in AWS ECS based on Terraform. Containers have finer resource granularity, better resource elasticity and resource utilization

### Terminology

- [Amazon Elastic Container Service(ECS)](https://aws.amazon.com/ecs/)is a serverless orchestrator that manages container deployments on your behalf.
- [Amazon Virtual Private Cloud(VPC)](https://aws.amazon.com/vpc/)helps you define and launch AWS resources in a logically isolated virtual network.
- [AWS Fargate](https://aws.amazon.com/fargate/)is a serverless compute engine for containers that works with both Amazon Elastic Container Service (ECS) and Amazon Elastic Kubernetes (EKS).
- [Terraform](https://www.terraform.io/) Infrastructure automation to provision and manage resources in any cloud or data center powered by HashiCorp

### Architecture

![image](https://github.com/mingyu110/Best-Practice/assets/48540798/c541cb8e-7ec8-436c-8fb9-cb01ac1e557e)

### Prerequisites

- AWS Account
- Domain Name
- Domain name Certificate hosted in AWS Certificate Manager

### Get Started

- All the demo scripts you can find it at https://github.com/mingyu110/Best-Practice/tree/master for reference

#### IAM Resource

- AWS IAM roles and policys can be subdivided into the permissions of each cloud resource and each operation. For details, refer to the AWS IAM documentations. You can grant the appropriate permissions according to the required scenarios

#### VPC Resource

- Use the official VPC Module provided by AWS and enable Internet Gatway(IGW), and configure three availability zones for each VPC, and one public subnet and one private subnet for each availability zone

#### Security Group(SG) Resource

- You can set security group rules for Intranet traffic based on your service scenario. This is only for example set forth herein.

#### EFS Resource

- Since Jenkins' official docker image uses jenkins user (non-root) as the run user, however, the EFS Volume configured in task-definition is mounted as root user by default. Therefore, jenkins users cannot read and write files to the mounted directory, so it is recommended to use the Access Point of AWS EFS so as to provide the mounted Volume. Access Point can specify users, permissions, and root directories for file requests.

#### ALB Resource

- Use ALB as inbound traffic interface of AWS ECS cluster

#### ECS Cluster Resource、ECS Task Resource、Service Discovery Resource、ECS Service Resource

- Build all of the above resources with Terraform

#### Cloudwatch Resource

- You need to create a log group before creating a log steam writted by ECS

#### Jenkins Configuration

- Configure ECS Fargate as slave node

#### Jenkins Jod Demostrations

- Write it with Jenkinsfile

### Reference
[Get Started with Terraform- AWS](https://developer.hashicorp.com/terraform/tutorials/aws-get-started?ajs_aid=ac04da81-7a07-4aea-a677-abba513a2c89&product_intent=terraform)
