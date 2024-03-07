
resource "aws_lb" "jenkins_master" {
  name               = var.public_load_balancer_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.jenkins_master_public_lb_sg.id]
  subnets            = [module.vpc.public_subnets[0], module.vpc.public_subnets[1], module.vpc.public_subnets[2]]

  # enable_deletion_protection = true
  enable_deletion_protection = false

  tags = merge(
    var.tags
  )
  depends_on = [
    module.vpc
  ]
}

resource "aws_lb_target_group" "ecs_jenkins_master" {
  name        = var.lb_target_group_name
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = module.vpc.vpc_id
  health_check {
    interval            = 60
    path                = "/login"
    port                = 8080
    protocol            = "HTTP"
    timeout             = 10
    unhealthy_threshold = 5
    healthy_threshold   = 5
    matcher             = "200"
  }
  tags = merge(
    var.tags
  )

  depends_on = [
    aws_lb.jenkins_master
  ]
}



resource "aws_lb_listener" "jenkins_master" {
  load_balancer_arn = aws_lb.jenkins_master.arn
  port              = 443
  protocol          = "HTTPS"
  certificate_arn   = data.aws_acm_certificate.jenkins.arn
  default_action {
    target_group_arn = aws_lb_target_group.ecs_jenkins_master.arn
    type             = "forward"
  }
  tags = merge(
    var.tags
  )
  depends_on = [
    aws_lb.jenkins_master
  ]
}


resource "aws_lb_listener" "redirect_to_443" {
  load_balancer_arn = aws_lb.jenkins_master.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
  tags = merge(
    var.tags
  )
  depends_on = [
    aws_lb.jenkins_master
  ]
}

# if you don't need to use HTTPS as the ingress: 
/* resource "aws_lb_listener" "jenkins_master" {
  load_balancer_arn = aws_lb.jenkins_master.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    target_group_arn = aws_lb_target_group.ecs_jenkins_master.arn
    type             = "forward"
  }
  tags = merge(
    var.tags
  )
  depends_on = [
    aws_lb.jenkins_master
  ]
} */
