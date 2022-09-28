locals {
  public_subnet_tags = merge(var.global_tags,
    {
      Subnet_Type = "Public"
      Terraform   = "true"
    }

  )
  private_subnet_tags = merge(var.global_tags,
    {
      Subnet_Type = "Private"
      Terraform   = "true"
    }

  )
}

module "minecraft_vpc" {
  source = "git://github.com/terraform-aws-modules/vpc/aws"

  name = "minecraft_vpc_${var.aws_region_shortname}"
  cidr = var.vpc_cidr

  create_igw = true

  enable_dns_hostnames = var.custom_dns ? true : false
  enable_dns_support   = var.custom_dns ? true : false
  enable_vpn_gateway   = true
  enable_nat_gateway   = true
  single_nat_gateway   = true

  enable_dhcp_options      = var.custom_dns ? true : false
  dhcp_options_domain_name = var.custom_dns ? var.vpc_dns_name : nil

  # Tags
  public_subnet_tags  = local.public_subnet_tags
  private_subnet_tags = local.private_subnet_tags
  vpc_tags            = local.vpc_tags

  for_each        = var.vpc_subnet_map
  azs             = each.value.az
  private_subnets = each.value.private_subnets
  public_subnets  = each.value.public_subnets

}
