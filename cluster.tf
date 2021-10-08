resource "aws_ecs_cluster" "project_ecs_cluster" {
  name = "${var.project_name}-cluster"
  tags = local.aws_tags
}

data "aws_ami" "project_ecs_ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn-ami-*-amazon-ecs-optimized"]
  }
}

resource "aws_launch_configuration" "project_ecs_lc" {
  image_id             = data.aws_ami.project_ecs_ami.image_id
  key_name             = ""
  instance_type        = var.cluster_instance_type
  iam_instance_profile = aws_iam_instance_profile.project_ecs_agent_profile.name
  security_groups      = [aws_security_group.project_ecs_ec2_ingress.id, aws_security_group.project_egress_all.id]
  user_data            = "#!/bin/bash\necho ECS_CLUSTER=${aws_ecs_cluster.project_ecs_cluster.name} >> /etc/ecs/ecs.config"
}



resource "aws_autoscaling_group" "project_ecs_asg" {
  name                      = "${var.project_name}-ecs-asg"
  vpc_zone_identifier       = module.project_private_subnets.*.aws_subnet_id
  launch_configuration      = aws_launch_configuration.project_ecs_lc.name
  desired_capacity          = var.cluster_scaling_setings.desired_capacity
  min_size                  = var.cluster_scaling_setings.min_size
  max_size                  = var.cluster_scaling_setings.max_size
  health_check_grace_period = var.cluster_scaling_setings.health_check_grace_period
  health_check_type         = var.cluster_scaling_setings.health_check_type
}

resource "aws_autoscaling_policy" "project_ecs_asg_policy" {
  name        = "${var.project_name}-cluster-scaling-policy"
  policy_type = "TargetTrackingScaling"

  autoscaling_group_name = aws_autoscaling_group.project_ecs_asg.name
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 80.0
  }
}
