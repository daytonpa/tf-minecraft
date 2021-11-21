
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