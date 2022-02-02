# Resources
resource "aws_network_interface" "server" {
  subnet_id = var.subnet_id
}

resource "aws_instance" "server" {
  ami                           = var.instance_ami
  subnet_id                     = var.subnet_id
  iam_instance_profile          = local.instance_profile
  instance_type                 = local.instance_type

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

resource "aws_ebs_volume" "server" {
  availability_zone = var.instance_az
  size              = var.ebs_volume_size
  encrypted         = true
  kms_key_id        = local.kms_key_id
  iops              = var.ebs_volume_iops
  snapshot_id       = var.restore_from_snapshot == true ? var.ebs_snapshot_id : null
  tags = {
    Name = "minecraft-server-device"
    instance = aws_instance.server.id
    backups_enabled = var.ebs_backups_enabled
  }
}

resource "aws_volume_attachment" "server" {
  device_name = "/dev/sdh"
  volume_id = aws_ebs_volume.server.id
  instance_id = aws_instance.server.id
}
