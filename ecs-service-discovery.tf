resource "aws_service_discovery_private_dns_namespace" "ecs" {
  name        = "ecs.local"
  description = "ecs service discovery dns ns"
  vpc         = module.vpc.vpc_id
  tags = merge(
    var.tags
  )
}

resource "aws_service_discovery_service" "jenkins_master" {
  name = "jenkins-master"

  dns_config {
    namespace_id = aws_service_discovery_private_dns_namespace.ecs.id

    dns_records {
      ttl  = 10
      type = "A"
    }

    routing_policy = "MULTIVALUE"
  }

  health_check_custom_config {
    failure_threshold = 1
  }
  tags = merge(
    var.tags
  )

  depends_on = [
    aws_service_discovery_private_dns_namespace.ecs
  ]
}
