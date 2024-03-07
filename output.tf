output "iam_role" {
  value = aws_iam_role.jenkins_ecs_role.arn
}

output "jenkins_master_private_dns_name" {
  value = aws_service_discovery_service.jenkins_master.name
}


output "alb_dns_name" {
  value = aws_lb.jenkins_master.dns_name
}
