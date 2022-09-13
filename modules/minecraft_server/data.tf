data "aws_ami" "minecraft_server" {
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn-ami*amazon-ecs-optimized"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["591542846629"] # AWS
}

data "aws_kms_key" "ebs" {
  key_id = local.kms_key_id
}

data "aws_subnet" "main" {
  id = local.subnet_id
}

data "aws_ec2_instance_type" "main" {
  instance_type = var.instance_type
}
