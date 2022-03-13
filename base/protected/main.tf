
# Global stuff

terraform {
  backend "s3" {
    bucket = "tf-minecraft-data-${var.region}"
    key    = "statefiles/base"
    region = var.region
  }
}
provider "aws" {
  region = var.region
  profile = "${var.account_id}/${var.iam_profile_name}"
}
resource "random_uuid" "terraform_stack_id" {}

# Data
# data "terraform_remote_statfile" "restricted" {
#   backend = "s3"
#   config = {
#     bucket = "tf-minecraft-data-${var.region}"
#     key = "statefiles/restricted"
#     region = var.region
#     profile = ""
#   }
# }
data "aws_ami" "latest" {
  most_recent = true
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"] # Canonical
}
data "aws_key_pair" "ssh" {

}
data "aws_kms_key" "encrypt" {

}
data "aws_subnet" "private_primary" {
  filter {
    name = "vpc-id"
    values = [data.terraform_remote_statfile.restricted.vpc_id]
  }
  tags = {
    Tier = "Private"
    primary = "true"
  }
}
data "aws_subnet" "private_recovery" {
  filter {
    name = "vpc-id"
    values = [data.terraform_remote_statfile.restricted.vpc_id]
  }
  tags = {
    Tier = "Private"
    primary = "false"
  }
}
data "aws_subnet" "public_primary" {
  filter {
    name = "vpc-id"
    values = [data.terraform_remote_statfile.restricted.vpc_id]
  }
  tags = {
    Tier = "Public"
    primary = "true"
  }
}
data "aws_subnet" "public_recovery" {
  filter {
    name = "vpc-id"
    values = [data.terraform_remote_statfile.restricted.vpc_id]
  }
  tags = {
    Tier = "Public"
    primary = "false"
  }
}

# Local vars
locals {
  global_tags = {
    tf-stack-id = resource.random_uuid.terraform_stack_id.value
  }
}

# Resources

