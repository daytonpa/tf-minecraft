locals {
  primary_subnet_id  = data.terraform_remote_state.stack_tier_01.outputs.public_subnet_ids[0]
  recovery_subnet_id = data.terraform_remote_state.stack_tier_01.outputs.public_subnet_ids[(length(data.terraform_remote_state.stack_tier_01.outputs.public_subnet_ids) - 1)]

  # snapshot_search_string = var.minecraft_server_data_regex

  timestamp = formatdate("YYYY-MM-DD-hh-mm-ss", timestamp())
}