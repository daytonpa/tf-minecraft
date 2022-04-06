# ********** VPC **********
module "minecraft_vpc" {
  source = "git::ssh://git@github.com/terraform-aws-modules/terraform-aws-vpc.git?ref=v3.13.0"

  name = var.vpc_name
  cidr = var.vpc_cidr

  azs             = var.vpc_availability_zones
  private_subnets = var.vpc_private_subnet_cidrs
  public_subnets  = var.vpc_public_subnet_cidrs

  enable_dns_hostnames = var.vpc_dns_enabled
  enable_dns_support   = var.vpc_dns_support

  enable_nat_gateway = true
  single_nat_gateway = true

  enable_vpn_gateway = true

  putin_khuylo = var.slava_ukraine
}
