module "project_vpc" {
  source     = "git@github.com:yshchegolev/aws-module-vpc.git"
  aws_tags   = local.aws_tags
  cidr_block = var.project_subnet
}

module "project_public_subnets" {
  source     = "git@github.com:yshchegolev/aws-module-subnet.git"
  count      = length(var.project_av_zones)
  av_zone    = element(var.project_av_zones, count.index % length(var.project_av_zones))
  aws_tags   = local.aws_tags
  cidr_block = cidrsubnet(var.project_subnet, 8, count.index)
  public_ip  = true
  vpc_id     = module.project_vpc.vpc_id
}

module "project_private_subnets" {
  source     = "git@github.com:yshchegolev/aws-module-subnet.git"
  count      = length(var.project_av_zones)
  av_zone    = element(var.project_av_zones, count.index % length(var.project_av_zones))
  aws_tags   = local.aws_tags
  cidr_block = cidrsubnet(var.project_subnet, 8, count.index + length(var.project_av_zones))
  public_ip  = false
  vpc_id     = module.project_vpc.vpc_id
}

resource "aws_internet_gateway" "project_igw" {
  vpc_id = module.project_vpc.vpc_id
  tags   = local.aws_tags
}

resource "aws_default_route_table" "project_default_rt" {
  default_route_table_id = module.project_vpc.default_rt_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.project_igw.id
  }
  tags = local.aws_tags
}

resource "aws_route_table_association" "public_rt" {
  count          = length(module.project_public_subnets)
  subnet_id      = module.project_public_subnets[count.index].aws_subnet_id
  route_table_id = aws_default_route_table.project_default_rt.id
}

resource "aws_eip" "project_nat_eip" {
  vpc  = true
  tags = local.aws_tags
}

resource "aws_nat_gateway" "project_nat_gateway" {
  subnet_id     = module.project_public_subnets[0].aws_subnet_id
  allocation_id = aws_eip.project_nat_eip.id
  tags          = local.aws_tags
  depends_on    = [aws_internet_gateway.project_igw]
}

resource "aws_route_table" "project_private_rt" {
  vpc_id = module.project_vpc.vpc_id
  tags   = local.aws_tags
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.project_nat_gateway.id
  }
}

resource "aws_route_table_association" "private_rt" {
  count          = length(module.project_private_subnets)
  subnet_id      = module.project_private_subnets[count.index].aws_subnet_id
  route_table_id = aws_route_table.project_private_rt.id
}