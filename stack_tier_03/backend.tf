# Global stuff
terraform {
  backend "s3" {
    bucket = "minecraft-terraform-states"
    key    = "statefiles/stack_tier_03.state"
    region = "us-east-2"

    dynamodb_table = "minecraft-terraform-state-lock"
    encrypt = true
  }
}

provider "aws" {
  region = var.region
  profile = var.profile
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
