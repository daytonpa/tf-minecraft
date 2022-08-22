
module "minecraft_network_and_firewalls" {
  source = "../modules/minecraft_firewall"

  minecraft_vpc_id = data.terraform_remote_state.stack_tier_01.outputs.vpc_id

  minecraft_server_port   = var.minecraft_server_port
  minecraft_bastion_port  = var.minecraft_bastion_port

  admin_cidrs             = var.admin_cidrs
  minecraft_enabled_cidrs = var.minecraft_enabled_cidrs
}