# data "aws_ami" "minecraft_server" {
#   most_recent = true
#   owners      = ["099720109477"] # Canonical
#   owners = [local.aws_ami_owner_id]
#   # name_regex = "${local.os_version}"
#   # filter {
#   #   name   = "platform"
#   #   values = [local.os_name]
#   # }
#   # filter {
#   #   name  = "architecture"
#   #   values = ["x86_64"]
#   # }
#   filter {
#     name   = "virtualization-type"
#     values = ["hvm"]
#   }
# }

data "aws_ami" "minecraft_server" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

data "aws_kms_key" "ebs" {
  key_id = local.kms_key_id
}

data "aws_subnet" "main" {
  id = local.subnet_id
}
