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
    volume_size = 32
  }

  vpc_security_group_ids = var.minecraft_server_sgs

  user_data = local.minecraft_server_user_data

  tags {
    Name = var.server_name
  }
}

resource "aws_ebs_volume" "server" {
  availability_zone = local.instance_az
  size              = 64
  encrypted         = true
  kms_key_id        = local.kms_key_id
  iops              = 500
  snapshot_id       = local.restore_from_snapshot == true ? local.ebs_snapshot_id : null
  tags = {
    Name = "minecraft-server-data"
    instance = aws_instance.server.id
  }
}

resource "aws_volume_attachment" "server" {
  device_name = "/dev/sdh"
  volume_id = aws_ebs_volume.server.id
  instance_id = aws_instance.server.id
}
