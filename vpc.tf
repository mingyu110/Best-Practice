locals {
  name_prefix = "${var.vpc_name}-${var.environment}"
}

# https://github.com/terraform-aws-modules/terraform-aws-vpc
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = local.name_prefix
  cidr = var.vpc_cidr

  azs             = ["${var.region}a", "${var.region}b", "${var.region}c"]
  public_subnets  = ["${var.public_subnet_1_cidr}", "${var.public_subnet_2_cidr}", "${var.public_subnet_3_cidr}"]
  private_subnets = ["${var.private_subnet_1_cidr}", "${var.private_subnet_2_cidr}", "${var.private_subnet_3_cidr}"]

  public_subnet_tags = {
    Name                     = "${local.name_prefix}-public-subnets"
    "kubernetes.io/role/elb" = "1"
  }
  private_subnet_tags = {
    Name = "${local.name_prefix}-private-subnets"
  }

  enable_dns_hostnames         = true
  enable_dns_support           = true
  enable_nat_gateway           = true
  single_nat_gateway           = true
  one_nat_gateway_per_az       = false
  create_database_subnet_group = false

  tags = merge(
    var.tags,
    { Name = local.name_prefix }
  )
}
