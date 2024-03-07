resource "aws_efs_file_system" "jenkins_ecs" {

  performance_mode = "maxIO"
  encrypted        = false
  throughput_mode  = "bursting"

  tags = merge(
    { Name = var.efs_name },
    var.tags
  )
  depends_on = [
    module.vpc
  ]
}


resource "aws_efs_mount_target" "efs_mount" {
  count           = length(module.vpc.private_subnets)
  file_system_id  = aws_efs_file_system.jenkins_ecs.id
  subnet_id       = module.vpc.private_subnets[count.index]
  security_groups = [aws_security_group.ecs_jenkins_service_sg.id]
  depends_on = [
    aws_efs_file_system.jenkins_ecs
  ]
}


resource "aws_efs_access_point" "jenkins_master" {
  file_system_id = aws_efs_file_system.jenkins_ecs.id

  posix_user {
    gid = 1000
    uid = 1000
  }

  root_directory {
    path = "/var/jenkins_home"
    creation_info {
      owner_gid   = 1000
      owner_uid   = 1000
      permissions = "0777"
    }
  }
  depends_on = [
    aws_efs_file_system.jenkins_ecs
  ]
}
