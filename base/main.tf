
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
  count = 1
  server_name = "minecraft-server-${count.index}"

  instance_ami = data.aws_ami.latest_ubuntu.id
  instance_az = ""
  instance_profile = "minecraft-server-role"
  instance_ssh_key = data.aws_key_pair.server.name
  instance_type = var.instance_class["server"]

  security_groups = []

  kms_key_id = data.aws_kms_key.encrypt.id

  # Root volume
  instance_volume_type = "gp3"
  instance_volume_iops = 1000
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
}