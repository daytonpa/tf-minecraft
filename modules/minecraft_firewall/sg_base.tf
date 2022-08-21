resource "aws_security_group" "base" {
  name = "minecraft-base-${aws_region_shortname}"
  description = "Base-level Security Group used for all servers."
  vpc_id = aws_vpc.main.id
}

# ********** EGRESS RULES **********
resource "aws_security_group_rule" "egress_base_http" {
  security_group_id = aws_security_group.base.id
  direction = "egress"
  to_port = 80
  from_port = 80
  protocol = "tcp"
  description = "HTTP"
}

resource "aws_security_group_rule" "egress_base_https" {
  security_group_id = aws_security_group.base.id
  direction = "egress"
  to_port = 443
  from_port = 443
  protocol = "tcp"
  description = "HTTPS"
}

resource "aws_security_group_rule" "egress_base_dns" {
  security_group_id = aws_security_group.base.id
  direction = "egress"
  to_port = 53
  from_port = 53
  protocol = "udp"
  description = "DNS/Chrony"
}

resource "aws_security_group_rule" "egress_base_smtp" {
  security_group_id = aws_security_group.base.id
  direction = "egress"
  to_port = 25
  from_port = 25
  protocol = "tcp"
  description = "Email"
}

# ********** INGRESS RULES **********
resource "aws_security_group_rule" "ingress_base_metrics_ne" {
  security_group_id = aws_security_group.minecraft_server.id
  direction = "ingress"
  to_port = 9100
  from_port = 9100
  protocol = "tcp"
  description = "Node Exporter"
  source_security_group_id = aws_security_group.minecraft_vpn.id
}

resource "aws_security_group_rule" "ingress_base_metrics_cw" {
  security_group_id = aws_security_group.minecraft_server.id
  direction = "ingress"
  to_port = 10203
  from_port = 10203
  protocol = "tcp"
  description = "Cloudwatch Agent"
  source_security_group_id = aws_security_group.minecraft_vpn.id
}
