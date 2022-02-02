

resource "aws_network_interface" "vpn" {
  subnet_id = var.instance_subnet
}

resource "aws_instance" "vpn" {
  ami                           = var.instance_ami
  subnet_id                     = var.instance_subnet
  iam_instance_profile          = var.instance_profile
  instance_type                 = var.instance_type

  associate_public_ip_address   = false

  key_name                      = var.instance_ssh_key

  network_interface {
    network_interface_id        = aws_network_interface.server.id
  }

  ebs_optimized                 = true
  root_block_device {
    delete_on_termination       = true
    encrypted                   = true
    kms_key_id                  = var.kms_key_id
    volume_type                 = var.instance_volume_type
    volume_size                 = var.instance_volume_size
    iops                        = var.instance_volume_iops
  }

  metadata_options {
    http_endpoint               = "enabled"
    http_put_response_hop_limit = 1
    http_token                  = "optional"
  }

  vpc_security_group_ids {

  }

  user_data                     = var.instance_user_data

  tags {
    Name                        = var.server_name
  }
}

resource "aws_nlb" "vpn" {
  name = ""
  availability_zones = []

  listener {
    instance_port = var.instance_port
    instance_protocol = "tcp"
    lb_port = var.vpn_access_port
    lb_protocol = "tcp"
  }

  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    target = "TCP:${var.instance_port}"
    interval = 30
  }
}