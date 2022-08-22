terraform {
  backend "s3" {
    bucket = "minecraft-terraform-states"
    key    = "statefiles/stack_tier_02.state"
    region = "us-east-2"

    dynamodb_table = "minecraft-terraform-state-lock"
    encrypt = true
  }
}

provider "aws" {
  region  = var.region
  profile = var.profile
  default_tags {
    tags = {
      teraform = "true"
      tf-stack = "stack_tier_02"
    }
  }
}

data "aws_caller_identity" "me" {}

data "terraform_remote_state" "stack_tier_01" {
  backend = "s3"
  config = {
    bucket = "minecraft-terraform-states"
    key = "statefiles/stack_tier_01.state"
    region = "us-east-2"
  }
}
