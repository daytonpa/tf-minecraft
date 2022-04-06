resource "aws_security_group" "minecraft_vpn" {
  name = "minecraft-vpn-${var.aws_region_shortname}"
  description = "Rules for the Minecraft VPN server."
  vpc_id = aws_vpc.main.id
}

# INGRESS RULES
resource "aws_security_group_rule" "minecraft_vpn_ingress_ssh" {
  security_group_id = aws_security_group.minecraft_server.id
  direction = "ingress"
  to_port = 22
  from_port = 22
  protocol = "tcp"
  description = "SSH"
  cidr_blocks = [var.my_cidr]
}

resource "aws_security_group_rule" "minecraft_server_ingress_vpn" {
  security_group_id = aws_security_group.minecraft_server.id
  direction = "ingress"
  to_port = var.minecraft_vpn_port
  from_port = var.minecraft_vpn_port
  protocol = "tcp"
  description = "Minecraft game"
  cidr_blocks = ["0.0.0.0/0"]
}

# EGRESS RULES
resource "aws_security_group_rule" "minecraft_vpn_egress_ssh" {
  security_group_id = aws_security_group.minecraft_server.id
  direction = "egress"
  to_port = 22
  from_port = 22
  protocol = "tcp"
  description = "SSH"
  source_security_group_id = aws_security_group.minecraft_server.id
}

resource "aws_security_group_rule" "minecraft_vpn_egress_game" {
  security_group_id = aws_security_group.minecraft_server.id
  direction = "egress"
  to_port = var.minecraft_server_port
  from_port = var.minecraft_server_port
  protocol = "tcp"
  description = "Minecraft game"
  source_security_group_id = aws_security_group.minecraft_server.id
}