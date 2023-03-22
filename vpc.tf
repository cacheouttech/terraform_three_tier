module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.19.0"
  
  #VPC Details
  name  = var.vpc_name
  cidr  = var.vpc_cidr_block
  azs                 = var.vpc_availability_zones
  private_subnets     = var.vpc_private_subnets
  public_subnets      = var.vpc_public_subnets
  
  #Database Details
  create_database_subnet_group = var.vpc_create_database_subnet_group
  create_database_subnet_route_table = var.vpc_create_database_subnet_route_table
  database_subnets    = var.vpc_database_subnets
  
  #NAT Gateway Outbound Traffic
  enable_nat_gateway = var.vpc_enable_nat_gateway
  single_nat_gateway = var.vpc_single_nat_gateway
  
  #DNS Parameters
  enable_dns_hostnames = true
  enable_dns_support = true
  
  public_subnet_tags = {
    Name = "public-subnets"
  }
  
  private_subnet_tags = {
    Name = "private-subnets"
  }
  
  database_subnet_tags = {
    Name = "database-subnets"
  }
  
  vpc_tags = {
    Name = "terraform-vpc"
  }
}

