
locals {
  instance_ami = var.ami
  instance_az = var.availability_zone
  instance_profile = var.instance_profile
  instance_ssh_key = var.ssh_key
  instance_type = var.instance_type
  
  kms_key_id = var.kms_key_id

  ebs_restore_from_snaphot = var.restore_from_snaphot
  ebs_snapshot_id = var.snapshot_id

  subnet_id = var.subnet_id
}

# Resources
resource "aws_network_interface" "server" {
  subnet_id = local.subnet_id
}

resource "aws_instance" "server" {
  ami = data.aws_ami.latest_ubuntu.id
  availability_zone = local.instance_az
  instance_type = local.instance_type
  iam_instance_profile = local.instance_profile

  associate_public_ip_address = false
  ebs_optimized = true
  key_name = data.aws_kms_key.ssh.name


  network_interface {
    network_interface_id = aws_network_interface.server.id
  }

  root_block_device {
    delete_on_termination = true
    encrypted = true
    kms_key_id = local.kms_key_id
    volume_type = "gp3"
    volume_size = 20
  }

  vpc_security_group_ids {

  }

  tags {
    Name = var.server_name
  }
}

resource "aws_ebs_volume" "server" {
  availability_zone = local.instance_az
  size              = 60
  encrypted         = true
  kms_key_id        = local.kms_key_id
  iops              = 3000
  snapshot_id       = local.restore_from_snapshot == true ? local.ebs_snapshot_id : null
  tags = {
    Name = "minecraft-server-device"
    instance = aws_instance.server.id
  }
}

resource "aws_volume_attachment" "server" {
  device_name = "/dev/sdh"
  volume_id = aws_ebs_volume.server.id
  instance_id = aws_instance.server.id
}