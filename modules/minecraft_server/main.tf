# Resources
resource "aws_network_interface" "server" {
  subnet_id = data.aws_subnet.main.id
  security_groups = var.minecraft_server_sgs
}

resource "aws_instance" "server" {
  ami = data.aws_ami.minecraft_server.id
  instance_type = local.instance_type
  iam_instance_profile = local.instance_profile

  ebs_optimized = true
  key_name = var.instance_ssh_key


  network_interface {
    network_interface_id = aws_network_interface.server.id
    device_index         = 0
  }

  root_block_device {
    delete_on_termination = true
    encrypted = true
    kms_key_id = data.aws_kms_key.ebs.arn
    volume_type = "gp3"
    volume_size = 32
  }

  user_data = local.minecraft_server_user_data

  tags = var.tags
}

resource "aws_ebs_volume" "server" {
  availability_zone = data.aws_subnet.main.availability_zone
  type = "gp3"
  throughput = 125
  size              = 64
  encrypted         = true
  kms_key_id        = data.aws_kms_key.ebs.arn
  iops              = 500
  # snapshot_id       = local.restore_from_snapshot == true ? local.ebs_snapshot_id : null
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
