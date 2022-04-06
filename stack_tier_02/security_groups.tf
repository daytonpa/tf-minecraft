
module "minecraft_network_and_firewalls" {
  source = "../modules/minecraft_firewall"

  minecraft_server_port = var.minecraft_server_port
  minecraft_vpn_port    = var.minecraft_vpn_port
}