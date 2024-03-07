resource "aws_ecs_task_definition" "jenkins_master" {
  family             = var.ecs_task_definitions_name
  task_role_arn      = aws_iam_role.jenkins_ecs_role.arn
  execution_role_arn = aws_iam_role.jenkins_ecs_role.arn
  network_mode       = "awsvpc"
  requires_compatibilities = [
    "FARGATE"
  ]
  cpu    = var.jenkins_master_cpu_size
  memory = var.jenkins_master_memory_size


  volume {
    name = "jenkins_home"

    # use efs directly, this way must be run container as root user. 
    # ref: https://stackoverflow.com/questions/61967965/how-to-run-nonroot-user-in-ecs  
    /* efs_volume_configuration {
      file_system_id = var.efs_id
      root_directory = "/"
    } */


    # use efs access point.
    efs_volume_configuration {
      file_system_id          = aws_efs_file_system.jenkins_ecs.id
      transit_encryption      = "ENABLED"
      transit_encryption_port = 2999
      root_directory          = "/"
      authorization_config {
        access_point_id = aws_efs_access_point.jenkins_master.id
        iam             = "ENABLED"
      }
    }

  }

  container_definitions = jsonencode(
    [
      {
        "name" : "jenkins-master",
        "image" : var.jenkins_master_image,
        "cpu" : var.jenkins_master_cpu_size,
        "memory" : var.jenkins_master_memory_size,
        "portMappings" : [
          {
            "containerPort" : 8080,
            "hostPort" : 8080,
            "protocol" : "tcp"
          },
          {
            "containerPort" : 50000,
            "hostPort" : 50000,
            "protocol" : "tcp"
          }
        ],
        "essential" : true,
        "environment" : [],
        "mountPoints" : [
          {
            "sourceVolume" : "jenkins_home",
            "containerPath" : "/var/jenkins_home"
          }
        ],
        "logConfiguration" : {
          "logDriver" : "awslogs",
          "options" : {
            "awslogs-group" : "/aws/ecs/${var.ecs_cluster_name}/${var.ecs_service_name}"
            "awslogs-region" : var.region,
            "awslogs-stream-prefix" : var.ecs_service_name
          }
        },
        "healthCheck" : {
          "command" : [
            "CMD-SHELL",
            "curl -f http://localhost:8080/login || exit 1"
          ],
          "interval" : 30,
          "timeout" : 5,
          "retries" : 3,
          "startPeriod" : 120
        }
      }
    ]
  )
  tags = merge(
    var.tags
  )
  depends_on = [
    aws_ecs_cluster.jenkins
  ]
}
