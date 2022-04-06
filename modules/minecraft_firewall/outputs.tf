output "sg_minecraft_server_id" {
  value = aws_security_group.server.id
}
output "sg_minecraft_vpn_id" {
  value = aws_security_group.vpn.id
}
output "sg_minecraft_base_id" {
  value = aws_security_group.vpn.id
}