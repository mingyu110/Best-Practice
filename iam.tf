resource "aws_iam_policy" "jenkins_ecs_policy" {
  name        = var.jenkins_ecs_policy_name
  description = "Policy for jenkins ecs task"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "elasticfilesystem:*",
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "cloudwatch:*",
                "logs:*",
                "ecr:*",
                "iam:PassRole",
                "ecs:*"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "ssmmessages:CreateControlChannel",
                "ssmmessages:CreateDataChannel",
                "ssmmessages:OpenControlChannel",
                "ssmmessages:OpenDataChannel"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "ecs:RegisterTaskDefinition",
                "ecs:ListClusters",
                "ecs:DescribeContainerInstances",
                "ecs:ListTaskDefinitions",
                "ecs:DescribeTaskDefinition",
                "ecs:DeregisterTaskDefinition",
                "ecs:ListContainerInstances",
                "ecs:DescribeClusters"
            ],
            "Resource": "*"
        }
    ]
}
EOF
  tags = merge(
    var.tags
  )
}

resource "aws_iam_role" "jenkins_ecs_role" {
  name        = var.jenkins_ecs_role_name
  description = "iam role for ecs jenkins task"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "",
            "Effect": "Allow",
            "Principal": {
                "Service": "ecs-tasks.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
EOF

  depends_on = [
    aws_iam_policy.jenkins_ecs_policy
  ]
  tags = merge(
    var.tags
  )
}

resource "aws_iam_role_policy_attachment" "jenkins_ecs_policy_attachment" {
  role       = aws_iam_role.jenkins_ecs_role.name
  policy_arn = aws_iam_policy.jenkins_ecs_policy.arn

  depends_on = [
    aws_iam_policy.jenkins_ecs_policy,
    aws_iam_role.jenkins_ecs_role
  ]
}
