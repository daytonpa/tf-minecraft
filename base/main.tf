
# Data from "restricted" build

# Data

data "aws_ami" "latest_ubuntu" {
  most_recent = true

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical

}

data "aws_kms_key" "ssh" {

}
data "aws_kms_key" "encrypt" {

}

# Resources

module "minecraft_server" "main" {

  for_each = var.minecraft_servers

  server_name = "minecraft-server-${count.index}"

  instance_ami = data.aws_ami.latest_ubuntu.id
  instance_az = each.value.az
  instance_profile = "minecraft-server-role"
  instance_ssh_key = data.aws_key_pair.server.name
  instance_type = each.value.instance_class

  security_groups = []

  kms_key_id = data.aws_kms_key.encrypt.id

  # Root volume
  instance_volume_type = "gp3"
  instance_volume_iops = 500
  instance_volume_size = 20

  # EBS data volume
  ebs_restore_from_snapshot = false
  # ebs_snaphot_id = null
  ebs_volume_type = "gp3"
  ebs_volume_iops = 3000
  ebs_volume_size = 60

  tags = {
  
  }

  lifecycle {
    ignore_changes = [instance_ami, tags]
  }
}

resource "aws_instance" "vpn_bastion" {
  ami = data.aws_ami.latest_ubuntu.id
  availability_zone = var.instance_az
  iam_instance_profile = "minecraft-bastion-role"
  instance_type = "t3.small"

  associate_public_ip_address = false

  key_name = data.aws_key_pair.server.name

  network_interface {
    network_interface_id = aws_network_interface.server.id
  }

  ebs_optimized = true
  root_block_device {
    delete_on_termination = true
    encrypted = true
    kms_key_id = data.aws_kms_key.encrypt.id
    volume_type = "gp3"
    volume_size = 20
  }

  metadata_options {
    http_endpoint = "enabled"
    http_put_response_hop_limit = 1
    http_token = "optional"
  }

  vpc_security_group_ids {

  }

  user_data = var.instance_user_data

  tags {
    Name = var.server_name
  }
}