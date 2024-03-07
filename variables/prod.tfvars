# general 
region = "ap-southeast-1"

environment = "prod"

tags = {
  creator   = "terraform"
  component = "jenkins"
  cost      = "devops"
}

# AWS Certificate Manager Certificates Domain name, it will be used to set up  SSL certificate for the ELB HTTPS ingress.
jenkins_master_domain = "www.example.com"


# iam
jenkins_ecs_role_name = "jenkins_ecs_role"

jenkins_ecs_policy_name = "jenkins_ecs_policy"

# vpc 
vpc_name              = "devops_infra"
vpc_cidr              = "10.99.99.0/24"
public_subnet_1_cidr  = "10.99.99.0/28"
public_subnet_2_cidr  = "10.99.99.16/28"
public_subnet_3_cidr  = "10.99.99.32/28"
private_subnet_1_cidr = "10.99.99.128/28"
private_subnet_2_cidr = "10.99.99.144/28"
private_subnet_3_cidr = "10.99.99.160/28"


# efs 
efs_name = "jenkins_ecs"

# cloudwatch 
awslogs_group         = "/ecs/devops_infra"
awslogs_stream_prefix = "jenkins"


# ecs 
ecs_cluster_name           = "devops_infra"
ecs_service_name           = "jenkins_service"
ecs_task_definitions_name  = "jenkins"
jenkins_master_image       = "jenkins/jenkins:2.361.1-lts"
jenkins_master_cpu_size    = 1024
jenkins_master_memory_size = 2048



# ingress(ELB)
lb_target_group_name      = "jenkins-master"
public_load_balancer_name = "jenkins-master"
