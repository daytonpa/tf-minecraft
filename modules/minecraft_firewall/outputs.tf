output "sg_minecraft_server_id" {
  value = aws_security_group.minecraft_server.id
}
output "sg_minecraft_bastion_id" {
  value = aws_security_group.minecraft_bastion.id
}
output "sg_minecraft_base_id" {
  value = aws_security_group.base.id
}