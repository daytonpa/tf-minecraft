# Global stuff
terraform {
  backend "s3" {
    bucket = "minecraft-terraform-states"
    key    = "statefiles/stack_tier_03.state"
    region = "us-east-2"

    dynamodb_table = "minecraft-terraform-state-lock"
    encrypt        = true
  }
}

provider "aws" {
  region  = var.region
  profile = var.profile
}
