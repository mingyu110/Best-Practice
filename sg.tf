resource "aws_security_group" "ecs_jenkins_service_sg" {
  name        = "${var.ecs_service_name}_sg"
  description = "Allow ALL traffic in private subnet for ECS internal service"
  vpc_id      = module.vpc.vpc_id

# This is only for demo,and it suggests you configure the policy tailored to your specific requirement
  ingress = [
    {
      description      = "Allow all private network inbound"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      self             = false
      security_groups  = []
      prefix_list_ids  = []
    }
  ]
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound"
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }
  tags = merge(
    var.tags
  )
  depends_on = [
    module.vpc
  ]
}

# This is only for demo, and it strongly suggests you limit the IP whitelist on product environment
# or use Internal Application Loading Balancing (ALB)
resource "aws_security_group" "jenkins_master_public_lb_sg" {
  name        = "public_${var.public_load_balancer_name}_sg"
  description = "Whitelist for Jenkins master WebUI in public network alb"
  vpc_id      = module.vpc.vpc_id


  ingress {
    description      = "Allow 443"
    from_port        = 443
    to_port          = 443
    protocol         = "TCP"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = []
    self             = false
  }

  ingress {
    description      = "Allow 80"
    from_port        = 80
    to_port          = 80
    protocol         = "TCP"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = []
    self             = false
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound"
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }
  tags = merge(
    var.tags
  )
  depends_on = [
    module.vpc
  ]
}
