variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "cluster_instance_type" {
  description = "AWS EC2 instance type for ECS cluster"
  type        = string
}

variable "cluster_scaling_setings" {
  description = "ECS cluster autoscaling settings"
  type        = map(any)
  default = {
    desired_capacity          = 3
    min_size                  = 3
    max_size                  = 9
    health_check_grace_period = 300
    health_check_type         = "EC2"
  }
}

variable "project_name" {
  description = "Name of project to be used in tags"
  type        = string
}

variable "project_subnet" {
  description = "Subnet for project to be assigned to VPC"
  type        = string
}

variable "project_av_zones" {
  type    = list(string)
  default = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
}

variable "project_creation_date" {
  description = "Date of project creation to be used in tags"
  type        = string
}

variable "project_image" {
  description = "Docker image for project"
  type        = string
}

variable "project_container_port" {
  description = "Port, exposed on container"
  type        = number
}

variable "project_cpu" {
  description = "Project CPU limit"
  type        = number
  default     = 128
}

variable "project_memory" {
  description = "Project memory limit"
  type        = number
  default     = 16
}

variable "project_app_protocol" {
  description = "Application web protocol"
  type        = string
}

variable "project_app_endpoint" {
  description = "Application endpoint"
  type        = string
}