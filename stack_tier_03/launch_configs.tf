# ********** AMIs **********
data "aws_ami" "ubuntu" {
  count = local.os_name == "ubuntu" ? 1 : 0
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-${local.os_version}-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_ami" "amazon" {
  count = local.os_name == "amazon" ? 1 : 0
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-${local.os_version}-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Launch configuration
data "template_file" "minecraft_server_user_data" {
  template = "../templates/user_data/minecraft_server.sh.tmpl"
  vars = {
    aws_region = ''
    chef_environment = ''
    chef_role = ''
    s3_chef_repo_bucket = ''
    s3_chef_repo_path = ''
  }
}

resource "aws_launch_configuration" "minecraft_server" {
  name = "minecraft-server-ubuntu-${local.timestamp}"

  iam_instance_profile = "minecraft-server-profile"
  key_name = data.terraform_remote_state.stack_01.kms_key_ebs

  image_id      = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  security_groups = [
    data.terraform_remote_state.stack_02.sg_minecraft_base_id,
    data.terraform_remote_state.stack_02.sg_minecraft_server_id
  ]

  ebs_optimized = true

  user_data = 

  lifecycle {
    create_before_destroy = true
  }
}