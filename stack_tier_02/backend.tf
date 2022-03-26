# Global stuff
terraform {
  backend "s3" {
    bucket = "tf-minecraft-data-${var.region}"
    key    = "statefiles/base"
    region = var.region

    dynamodb_table = "tf-minecraft-"
    encrypt = true
  }
}

provider "aws" {
  region = var.region
  profile = "${var.account_id}/${var.iam_profile_name}"
}

# Remote state
data "terraform_remote_state" "stack_01" {
  backend = "s3"
  config = {
    bucket = "minecraft-terraform-states"
    key = "statefiles/stack_tier_01.state"
    region = "us-east-2"
  }
}
