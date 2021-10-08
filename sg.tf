resource "aws_security_group" "project_ingress_http_lb" {
  name        = "${var.project_name}-ingress-lb"
  description = "Allow all egress TCP traffic"
  vpc_id      = module.project_vpc.vpc_id
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = local.aws_tags
}

resource "aws_security_group" "project_ecs_ec2_ingress" {
  name        = "${var.project_name}-ec2-ingress-ports"
  description = "Allow traffic for ECS servers"
  vpc_id      = module.project_vpc.vpc_id

  ingress {
    from_port       = 32768
    to_port         = 65535
    protocol        = "tcp"
    security_groups = [aws_security_group.project_ingress_http_lb.id]
  }
  tags = local.aws_tags
}

resource "aws_security_group" "project_egress_all" {
  name        = "egress all"
  description = "all"
  vpc_id      = module.project_vpc.vpc_id
  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}