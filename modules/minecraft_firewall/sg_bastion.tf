resource "aws_security_group" "minecraft_bastion" {
  name        = "minecraft-bastion-${var.aws_region_shortname}"
  description = "Rules for the Minecraft bastion server."
  vpc_id      = var.minecraft_vpc_id
}

# INGRESS RULES
resource "aws_security_group_rule" "minecraft_server_ingress_bastion" {
  security_group_id = aws_security_group.minecraft_server.id
  type              = "ingress"
  to_port           = var.minecraft_bastion_port
  from_port         = var.minecraft_bastion_port
  protocol          = "tcp"
  description       = "Minecraft game"
  cidr_blocks       = var.minecraft_enabled_cidrs
}

# EGRESS RULES
resource "aws_security_group_rule" "minecraft_bastion_egress_ssh" {
  security_group_id        = aws_security_group.minecraft_server.id
  type                     = "egress"
  to_port                  = 22
  from_port                = 22
  protocol                 = "tcp"
  description              = "SSH"
  source_security_group_id = aws_security_group.minecraft_server.id
}

resource "aws_security_group_rule" "minecraft_bastion_egress_game" {
  security_group_id        = aws_security_group.minecraft_server.id
  type                     = "egress"
  to_port                  = var.minecraft_server_port
  from_port                = var.minecraft_server_port
  protocol                 = "tcp"
  description              = "Minecraft game"
  source_security_group_id = aws_security_group.minecraft_server.id
}