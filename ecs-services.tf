resource "aws_ecs_service" "jenkins_master" {
  name                               = var.ecs_service_name
  cluster                            = aws_ecs_cluster.jenkins.id
  desired_count                      = 1
  enable_execute_command             = true
  platform_version                   = "LATEST"
  task_definition                    = aws_ecs_task_definition.jenkins_master.arn
  deployment_maximum_percent         = 200
  deployment_minimum_healthy_percent = 100
  launch_type                        = "FARGATE"
  # iam_role                           = var.ecs_task_role_arn 
  network_configuration {
    assign_public_ip = false
    security_groups = [
      aws_security_group.ecs_jenkins_service_sg.id
    ]
    subnets = tolist(module.vpc.private_subnets)
  }
  load_balancer {
    target_group_arn = aws_lb_target_group.ecs_jenkins_master.arn
    container_name   = "jenkins-master"
    container_port   = 8080
  }

  service_registries {
    registry_arn = aws_service_discovery_service.jenkins_master.arn
  }
  scheduling_strategy = "REPLICA"

  tags = merge(
    var.tags
  )
  depends_on = [
    aws_ecs_task_definition.jenkins_master,
    aws_lb_target_group.ecs_jenkins_master,
    aws_efs_file_system.jenkins_ecs
  ]
}
