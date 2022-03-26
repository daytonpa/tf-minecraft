resource "aws_kms_key" "minecraft_ebs" {
  descripton = "Key used for encrypting EBS devices."
  is_enabled = true
  key_usage = "ENCRYPT_DECRYPT"

  tags = {
    Name = "minecraft-kms-ebs-${local.region_shortname}"
  }
}

resource "aws_kms_key" "minecraft_s3" {
  descripton = "Key used for encrypting S3 objects."
  is_enabled = true
  key_usage = "ENCRYPT_DECRYPT"

  tags = {
    Name = "minecraft-kms-s3-${local.region_shortname}"
  }
}