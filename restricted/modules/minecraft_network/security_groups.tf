resource "aws_security_group" "base" {
  name = "minecraft-vpc-base"
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # We'll tighten this up later
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_security_group" "bastion" {
  name = "minecraft-vpc-base"
  vpc_id = aws_vpc.main.id
}
resource "aws_security_group_rule" "bastion_ssh_ingress" {
  type              = "ingress"
  description       = "SSH inbound traffic (maintenance)"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.bastion.id
}
resource "aws_security_group_rule" "bastion_vpn_ingress" {
  type              = "ingress"
  description       = "VPN inbound traffic"
  from_port         = 1234
  to_port           = 1234
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.bastion.id
}
resource "aws_security_group_rule" "bastion_vpn_egress" {
  type              = "egress"
  description       = "VPN outbound traffic to Minecraft servers"
  from_port         = 1234
  to_port           = 1234
  protocol          = "tcp"
  cidr_blocks       = ["10.0.0.0/26"]
  security_group_id = aws_security_group.bastion.id
}
resource "aws_security_group_rule" "bastion_to_server_ssh" {
  type              = "egress"
  description       = "SSH to Minecraft servers (maintenance)"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = aws_security_group.server.id
  security_group_id = aws_security_group.bastion.id
}

resource "aws_security_group" "server" {
  name = "minecraft-vpc-base"
  vpc_id = aws_vpc.main.id
}
resource "aws_security_group_rule" "server_ssh_ingress" {
  type              = "ingress"
  description       = "SSH to Minecraft servers (maintenance)"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = aws_security_group.bastion.id
  security_group_id = aws_security_group.server.id
}
resource "aws_security_group_rule" "server_vpn_ingress" {
  type              = "ingress"
  description       = "VPN to Minecraft server"
  from_port         = 44945
  to_port           = 44945
  protocol          = "tcp"
  source_security_group_id = aws_security_group.bastion.id
  security_group_id = aws_security_group.server.id
}