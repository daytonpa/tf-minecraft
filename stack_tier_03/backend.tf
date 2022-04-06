# Global stuff
terraform {
  backend "s3" {
    bucket = "tf-minecraft-data-${var.region}"
    key    = "statefiles/base"
    region = var.region

    dynamodb_table = "minecraft-terraform-state-lock"
    encrypt = true
  }
}

provider "aws" {
  region = var.region
  profile = "${var.account_id}/${var.iam_profile_name}"
}

# Remote states
data "terraform_remote_state" "stack_01" {
  backend = "s3"
  config = {
    bucket = "minecraft-terraform-states"
    key = "statefiles/stack_tier_01.state"
    region = "us-east-2"
  }
}

data "terraform_remote_state" "stack_02" {
  backend = "s3"
  config = {
    bucket = "minecraft-terraform-states"
    key = "statefiles/stack_tier_02.state"
    region = "us-east-2"
  }
}