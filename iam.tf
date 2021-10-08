# https://docs.aws.amazon.com/AmazonECS/latest/developerguide/instance_IAM_role.html
resource "aws_iam_role" "project_main_role" {
  name = "${var.project_name}-main-role"

  assume_role_policy = <<EOF
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF

  tags = local.aws_tags
}

data "aws_iam_policy_document" "project_ecs_policy_doc" {
  statement {
    sid       = "ecs"
    effect    = "Allow"
    resources = ["*"]
    actions = [
      "ec2:DescribeTags",
      "ecs:CreateCluster",
      "ecs:DeregisterContainerInstance",
      "ecs:DiscoverPollEndpoint",
      "ecs:Poll",
      "ecs:RegisterContainerInstance",
      "ecs:StartTelemetrySession",
      "ecs:UpdateContainerInstancesState",
      "ecs:Submit*",
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]
  }
}

resource "aws_iam_policy" "project_ecs_policy" {
  name        = "${var.project_name}-ecs-policy"
  description = "ECS Policy"
  policy      = data.aws_iam_policy_document.project_ecs_policy_doc.json
}

resource "aws_iam_role_policy_attachment" "project_ecs_attachment" {
  role       = aws_iam_role.project_main_role.name
  policy_arn = aws_iam_policy.project_ecs_policy.arn
}

data "aws_iam_policy_document" "project_ecs_agent_doc" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "project_ecs_agent_role" {
  name               = "${var.project_name}-ecs-agent-role"
  assume_role_policy = data.aws_iam_policy_document.project_ecs_agent_doc.json
}


resource "aws_iam_role_policy_attachment" "project_ecs_agent_attach" {
  role       = aws_iam_role.project_ecs_agent_role.name
  policy_arn = aws_iam_policy.project_ecs_policy.arn
}

resource "aws_iam_instance_profile" "project_ecs_agent_profile" {
  name = "${var.project_name}-ecs-agent-instance-profile"
  role = aws_iam_role.project_ecs_agent_role.name
}
