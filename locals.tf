locals {
  aws_tags = {
    Name             = var.project_name
    Resource_created = var.project_creation_date
  }
}