module "service" {
  source = "git@github.com:yshchegolev/aws-moodule-service.git"

  alb_security_groups    = [aws_security_group.project_egress_all.id, aws_security_group.project_ingress_http_lb.id]
  alb_subnets            = module.project_public_subnets.*.aws_subnet_id
  aws_region             = var.aws_region
  aws_tags               = local.aws_tags
  ecs_cluster_id         = aws_ecs_cluster.project_ecs_cluster.id
  project_container_port = var.project_container_port
  project_image          = var.project_image
  project_name           = var.project_name
  vpc_id                 = module.project_vpc.vpc_id
  lb_protocol            = var.project_app_protocol
  healthcheck_endpoint   = var.project_app_endpoint

}