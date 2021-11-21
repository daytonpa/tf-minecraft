locals {
  region_shortname = "use1" ? var.region == "us-east-1" : "use2"
}

resource "aws_kms_key" "minecraft" {
  descripton = "Key used for encrypting S3 objects and EBS devices."
  is_enabled = true
  key_usage = "ENCRYPT_DECRYPT"

  tags = {
    Name = "minecraft-kms-key-${local.region_shortname}"
  }
}

resource "aws_s3_bucket" "minecraft" {
  bucket = "minecraft-${local.region_shortname}-bucket"
  acl    = "private"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.minecraft.arn
        sse_algorithm     = "aws:kms"
      }
    }
  }

  tags = {
    Name = "minecraft-${local.region_shortname}-logs"
  }
}

resource "aws_s3_bucket" "logs" {
  bucket = "minecraft-bucket-${local.region_shortname}"
  acl    = "log-delivery-write"

  tags = {
    Name = "logs-${local.region_shortname}"
  }
}