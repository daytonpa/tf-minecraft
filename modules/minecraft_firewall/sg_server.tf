resource "aws_security_group" "minecraft_server" {
  name = "minecraft-base-"
  vpc_id = aws_vpc.main.id
}

# INGRESS RULES
resource "aws_security_group_rule" "minecraft_server_ingress_ssh" {
  security_group_id = aws_security_group.minecraft_server.id
  direction = "ingress"
  to_port = 22
  from_port = 22
  protocol = "tcp"
  description = "SSH"
  source_security_group_id = aws_security_group.minecraft_vpn.id
}

resource "aws_security_group_rule" "minecraft_server_ingress_game" {
  security_group_id = aws_security_group.minecraft_server.id
  direction = "ingress"
  to_port = var.minecraft_server_port
  from_port = var.minecraft_server_port
  protocol = "tcp"
  description = "Minecraft game"
  source_security_group_id = aws_security_group.minecraft_vpn.id
}