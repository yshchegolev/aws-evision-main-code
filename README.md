## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~>1.0.4 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.61.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 3.61.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_project_private_subnets"></a> [project\_private\_subnets](#module\_project\_private\_subnets) | git@github.com:yshchegolev/aws-module-subnet.git |  |
| <a name="module_project_public_subnets"></a> [project\_public\_subnets](#module\_project\_public\_subnets) | git@github.com:yshchegolev/aws-module-subnet.git |  |
| <a name="module_project_vpc"></a> [project\_vpc](#module\_project\_vpc) | git@github.com:yshchegolev/aws-module-vpc.git |  |
| <a name="module_service"></a> [service](#module\_service) | git@github.com:yshchegolev/aws-moodule-service.git |  |

## Resources

| Name | Type |
|------|------|
| [aws_autoscaling_group.project_ecs_asg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group) | resource |
| [aws_autoscaling_policy.project_ecs_asg_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_policy) | resource |
| [aws_default_route_table.project_default_rt](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_route_table) | resource |
| [aws_ecs_cluster.project_ecs_cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_cluster) | resource |
| [aws_eip.project_nat_eip](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_iam_instance_profile.project_ecs_agent_profile](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_policy.project_ecs_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.project_ecs_agent_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.project_main_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.project_ecs_agent_attach](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.project_ecs_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_internet_gateway.project_igw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_launch_configuration.project_ecs_lc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_configuration) | resource |
| [aws_nat_gateway.project_nat_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_route_table.project_private_rt](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.private_rt](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.public_rt](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_security_group.project_ecs_ec2_ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.project_egress_all](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.project_ingress_http_lb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_ami.project_ecs_ami](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_iam_policy_document.project_ecs_agent_doc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.project_ecs_policy_doc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region | `string` | n/a | yes |
| <a name="input_cluster_instance_type"></a> [cluster\_instance\_type](#input\_cluster\_instance\_type) | AWS EC2 instance type for ECS cluster | `string` | n/a | yes |
| <a name="input_cluster_scaling_setings"></a> [cluster\_scaling\_setings](#input\_cluster\_scaling\_setings) | ECS cluster autoscaling settings | `map(any)` | <pre>{<br>  "desired_capacity": 3,<br>  "health_check_grace_period": 300,<br>  "health_check_type": "EC2",<br>  "max_size": 9,<br>  "min_size": 3<br>}</pre> | no |
| <a name="input_project_app_endpoint"></a> [project\_app\_endpoint](#input\_project\_app\_endpoint) | Application endpoint | `string` | n/a | yes |
| <a name="input_project_app_protocol"></a> [project\_app\_protocol](#input\_project\_app\_protocol) | Application web protocol | `string` | n/a | yes |
| <a name="input_project_av_zones"></a> [project\_av\_zones](#input\_project\_av\_zones) | n/a | `list(string)` | <pre>[<br>  "eu-central-1a",<br>  "eu-central-1b",<br>  "eu-central-1c"<br>]</pre> | no |
| <a name="input_project_container_port"></a> [project\_container\_port](#input\_project\_container\_port) | Port, exposed on container | `number` | n/a | yes |
| <a name="input_project_cpu"></a> [project\_cpu](#input\_project\_cpu) | Project CPU limit | `number` | `128` | no |
| <a name="input_project_creation_date"></a> [project\_creation\_date](#input\_project\_creation\_date) | Date of project creation to be used in tags | `string` | n/a | yes |
| <a name="input_project_image"></a> [project\_image](#input\_project\_image) | Docker image for project | `string` | n/a | yes |
| <a name="input_project_memory"></a> [project\_memory](#input\_project\_memory) | Project memory limit | `number` | `16` | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Name of project to be used in tags | `string` | n/a | yes |
| <a name="input_project_subnet"></a> [project\_subnet](#input\_project\_subnet) | Subnet for project to be assigned to VPC | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_service_dns_name"></a> [service\_dns\_name](#output\_service\_dns\_name) | Service DNS name |
