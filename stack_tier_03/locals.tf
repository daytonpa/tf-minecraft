locals {
  os_name     = var.os_name
  os_version  = var.os_version

  primary_subnet_id = data.terraform_remote_state.stack_01.public_subnets[0]
  recovery_subnet_id = data.terraform_remote_state.stack_01.public_subnets[-1]

  snapshot_search_string = var.minecraft_server_data_regex

  timestamp = formatdate("YYYY-MM-DD-hh-mm-ss")
}