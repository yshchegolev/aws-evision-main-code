project_name           = "wk-ecs-tf"
aws_region             = "eu-central-1"
project_creation_date  = "07/10/21"
project_subnet         = "10.15.0.0/16"
cluster_instance_type  = "t2.micro"
project_image          = "cardiffc/evision:1.0.1"
project_container_port = 8080
project_app_protocol   = "HTTP"
project_app_endpoint   = "/success"