
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

# Local vars
locals {
  global_tags = {
    tf-stack-id = resource.random_uuid.terraform_stack_id.value
  }
}

# Resources
resource "aws_kms_key" "minecraft" {
  descripton = "Key used for encrypting S3 objects and EBS devices."
  is_enabled = true
  key_usage = "ENCRYPT_DECRYPT"

  tags = {
    Name = "minecraft-kms-key-${local.region_shortname}"
  }
}
