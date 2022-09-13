output "minecraft_server_ip" {
  value = aws_instance.server.public_ip
}
output "ssh_minecraft_server" {
  value = "ssh -i ~/.ssh/minecraft-server.pem ec2-user@${aws_instance.server.public_dns}"
}