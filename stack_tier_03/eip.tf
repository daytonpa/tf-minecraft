# ********** EIP **********
resource "aws_eip" "minecraft" {
  vpc      = true
  associate_with_private_ip = "10.20.30.25"
  private_dns = "mineraft.bearclawgohard.com"
}

resource "aws_eip" "vpn" {
  vpc      = true
}