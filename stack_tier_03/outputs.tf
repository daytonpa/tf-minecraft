output "minecraft_server_ip" {
  value = module.minecraft_server["minecraft-server-main"].minecraft_server_ip
}
output "ssh_minecraft_server" {
  value = module.minecraft_server["minecraft-server-main"].ssh_minecraft_server
}