variable "region" {
  description = "resource region name"
  default     = "ap-southeast-1"
}

variable "environment" {
  description = "environment name"
  type        = string
}

variable "tags" {
  description = "A map of tags to add to created resource"
  type        = map(any)
}



############ IAM 
variable "jenkins_ecs_role_name" {
  description = "iam role name for ecs jenkins"
  type        = string
}


variable "jenkins_ecs_policy_name" {
  description = "iam policy name for ecs jenkins"
  type        = string
}
#################


############ ECS 
variable "ecs_cluster_name" {
  description = "ecs cluster name"
  type        = string
}

variable "ecs_service_name" {
  description = "service name for ecs jenkins"
  type        = string
}

variable "ecs_task_definitions_name" {
  description = "ecs task definitions name"
  type        = string
}

variable "jenkins_master_image" {
  description = "docker image for jenkins master"
  type        = string
}

variable "jenkins_master_cpu_size" {
  description = "cpu limit for ecs jenkins master container"
}

variable "jenkins_master_memory_size" {
  description = "memory limit for ecs jenkins master container"
}
########


############ awslog 
variable "awslogs_group" {
  description = "cloudwatch log group name"
  type        = string
}

variable "awslogs_stream_prefix" {
  description = "cloudwatch log stream prefix"
  type        = string
}
########

########### loadbalancer  
variable "lb_target_group_name" {
  description = "target group name for loadbalancer"
  type        = string
}

variable "public_load_balancer_name" {
  description = "loadbalancer name"
  type        = string
}

variable "jenkins_master_domain" {
  description = "jenkins master certificate domain"
  type        = string
}
############

######## efs ########
variable "efs_name" {
  description = "efs name"
  type        = string
}



######## vpc ########

variable "vpc_name" {
  description = "private subnet 1"
  type        = string
}

variable "vpc_cidr" {
  description = "vcp cidr"
  default     = "10.42.0.0/16"
}

variable "public_subnet_1_cidr" {
  description = "Public Subnet 1 cidr block"
}
variable "public_subnet_2_cidr" {
  description = "Public Subnet 2 cidr block"
}
variable "public_subnet_3_cidr" {
  description = "Public Subnet 3 cidr block"
}
variable "private_subnet_1_cidr" {
  description = "Private Subnet 1 cidr block"
}
variable "private_subnet_2_cidr" {
  description = "Private Subnet 2 cidr block"
}

variable "private_subnet_3_cidr" {
  description = "Private Subnet 3 cidr block"
}
