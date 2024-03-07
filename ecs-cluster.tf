resource "aws_ecs_cluster" "jenkins" {
  name = var.ecs_cluster_name
  tags = merge(
    var.tags
  )
}
