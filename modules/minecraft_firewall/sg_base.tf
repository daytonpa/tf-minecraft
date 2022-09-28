resource "aws_security_group" "base" {
  name        = "minecraft-base-${var.aws_region_shortname}"
  description = "Base-level Security Group used for all servers."
  vpc_id      = var.minecraft_vpc_id
}

# ********** EGRESS RULES **********
resource "aws_security_group_rule" "egress_base_http" {
  security_group_id = aws_security_group.base.id
  type              = "egress"
  to_port           = 80
  from_port         = 80
  protocol          = "tcp"
  description       = "HTTP"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "egress_base_https" {
  security_group_id = aws_security_group.base.id
  type              = "egress"
  to_port           = 443
  from_port         = 443
  protocol          = "tcp"
  description       = "HTTPS"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "egress_base_dns" {
  security_group_id = aws_security_group.base.id
  type              = "egress"
  to_port           = 53
  from_port         = 53
  protocol          = "udp"
  description       = "DNS/Chrony"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "egress_base_smtp" {
  security_group_id = aws_security_group.base.id
  type              = "egress"
  to_port           = 25
  from_port         = 25
  protocol          = "tcp"
  description       = "Email"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "egress_base_everything" {
  security_group_id = aws_security_group.base.id
  type              = "egress"
  to_port           = 0
  from_port         = 0
  protocol          = "-1"
  description       = "World"
  cidr_blocks       = ["0.0.0.0/0"]
}

# ********** INGRESS RULES **********
resource "aws_security_group_rule" "ingress_base_admin_ssh" {
  security_group_id = aws_security_group.minecraft_server.id
  type              = "ingress"
  to_port           = 22
  from_port         = 22
  protocol          = "tcp"
  description       = "Admin SSH"
  cidr_blocks       = var.admin_cidrs
}

resource "aws_security_group_rule" "ingress_base_metrics_ne" {
  security_group_id        = aws_security_group.minecraft_server.id
  type                     = "ingress"
  to_port                  = 9100
  from_port                = 9100
  protocol                 = "tcp"
  description              = "Node Exporter"
  source_security_group_id = aws_security_group.base.id
}

# resource "aws_security_group_rule" "ingress_base_metrics_cw" {
#   security_group_id = aws_security_group.minecraft_server.id
#   type = "ingress"
#   to_port = 10203
#   from_port = 10203
#   protocol = "tcp"
#   description = "Cloudwatch Agent"
#   cidr_blocks = ["0.0.0.0/0"]
# }
