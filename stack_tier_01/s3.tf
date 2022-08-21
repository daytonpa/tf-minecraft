# ********** S3 **********
# Data bucket
resource "aws_s3_bucket" "minecraft_data" {
  bucket = var.s3_minecraft_data_bucket_name
}

resource "aws_s3_bucket_acl" "minecraft_data" {
  bucket = aws_s3_bucket.minecraft_data.id
  acl    = "private"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "minecraft_data" {
  bucket = aws_s3_bucket.minecraft_data.bucket

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.minecraft_data_bucket.key_id
      sse_algorithm     = "aws:kms"
    }
  }
}