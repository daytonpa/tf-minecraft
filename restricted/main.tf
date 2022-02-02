terraform {
  backend "s3" {
    bucket = "tf-minecraft-data-us-east-1"
    key    = "statefiles/base"
    region = "us-east-1" 
  }
}
provider "aws" {
  region = "us-east-1"
  alias = "use1"
}
provider "aws" {
  region = "us-east-2"
  alias = "use2"
}
resource "random_uuid" "terraform_stack_id" {}

# Create our VPC, subnets, and security groups
module "minecraft_network" {
  source = "./modules/minecraft_network"

  region = var.region
  region_alias = var.region_alias
  primary_availability_zone = var.primary_az
  recovery_availability_zone = var.recovery_az

  vpn_connection_port = var.vpn_port
  server_connection_port = var.server_port
}

# module "minecraft_buckets" {
#   source = "./modules/minecraft_buckets"
#   region = var.region
#   data_bucket_name = "minecraft-data-${var.region}"
#   logs_bucket_name = "minecraft-logs-${var.region}"
# }