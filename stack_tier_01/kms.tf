# ********** KMS **********
# KMS Key for encrypting S3 data Bucket
resource "aws_kms_key" "minecraft_data_bucket" {
  description = "Terraform-managed KMS key for data in S3."
  is_enabled  = true
  key_usage   = "ENCRYPT_DECRYPT"

  tags = {
    Name = var.s3_kms_key_name
  }
}

# KMS Key for encryptring EBS Volumes
resource "aws_kms_key" "minecraft_ebs_volumes" {
  description = "Key used for encrypting S3 objects and EBS devices."
  is_enabled  = true
  key_usage   = "ENCRYPT_DECRYPT"

  tags = {
    Name = var.ebs_kms_key_name
  }
}
