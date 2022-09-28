resource "aws_kms_key" "ssm" {
  description = "SSM secrets KMS key."
  key_usage   = "ENCRYPT_DECRYPT"

  tags = {
    Name = "minecraft-kms-ssm"
  }
}
resource "aws_kms_key" "ebs" {
  description = "EBS KMS key."
  key_usage   = "ENCRYPT_DECRYPT"

  tags = {
    Name = "minecraft-kms-ebs"
  }
}

resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "ssh" {
  key_name   = "minecraft-ssh-key"
  public_key = tls_private_key.ssh.public_key_openssh
}

resource "aws_ssm_parameter" "ssh" {
  name        = "/ssh/server"
  description = "The private SSH Key for EC2 instances."
  type        = "SecureString"
  key_id      = aws_kms_key.ssm.id
  value       = tls_private_key.ssh.private_key_openssh

  tags = {
    Name = "/ssh/server"
  }
}

resource "local_sensitive_file" "ssh" {
  count           = var.write_ssh_key_to_file == true ? 1 : 0
  filename        = pathexpand("~/.ssh/minecraft-server.pem")
  file_permission = "0400"
  content         = tls_private_key.ssh.private_key_openssh
}
