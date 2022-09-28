# Remote states
data "terraform_remote_state" "stack_tier_01" {
  backend = "s3"
  config = {
    bucket = "minecraft-terraform-states"
    key    = "statefiles/stack_tier_01.state"
    region = "us-east-2"
  }
}

data "terraform_remote_state" "stack_tier_02" {
  backend = "s3"
  config = {
    bucket = "minecraft-terraform-states"
    key    = "statefiles/stack_tier_02.state"
    region = "us-east-2"
  }
}
