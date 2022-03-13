resource "aws_security_group" "base" {
  name = "minecraft-vpc-base"
  vpc_id = aws_vpc.main.id
}

resource "aws_security_group_rule" "egress_ssh" {
  security_group_id = aws_security_group.base.id
  direction = "egress"
  to_port = 22
  from_port = 22
  protocol = "tcp"
  description = "HTTP"
}


resource "aws_security_group_rule" "egress_http" {
  security_group_id = aws_security_group.base.id
  direction = "egress"
  to_port = 80
  from_port = 80
  protocol = "tcp"
  description = "HTTP"
}

resource "aws_security_group_rule" "egress_http" {
  security_group_id = aws_security_group.base.id
  direction = "egress"
  to_port = 443
  from_port = 443
  protocol = "tcp"
  description = "HTTPS"
}

resource "aws_security_group_rule" "egress_dns" {
  security_group_id = aws_security_group.base.id
  direction = "egress"
  to_port = 53
  from_port = 53
  protocol = "udp"
  description = "DNS/Chrony"
}