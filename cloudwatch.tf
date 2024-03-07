resource "aws_cloudwatch_log_group" "jenkins_ecs_log_group" {
  name              = "/aws/ecs/${var.ecs_cluster_name}/${var.ecs_service_name}"
  retention_in_days = 7
  tags = merge(
    var.tags
  )
}

resource "aws_cloudwatch_log_stream" "jenkins_ecs_log_stream" {
  name           = var.ecs_service_name
  log_group_name = aws_cloudwatch_log_group.jenkins_ecs_log_group.name
}
