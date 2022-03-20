# DynamoDB
locals {
  dbname = var.backend_dynamodb_table_name
  dbr    = var.backend_dynamodb_table_read
  dbw    = var.backend_dynamodb_table_write
  s3name = var.backend_s3_bucket_name
  s3e    = var.backend_s3_bucket_encrypt
  kmsid  = var.backend_s3_bucket_encryption_key_id
}


resource "aws_dynamodb_table" "terraform_lock" {
  name           = local.dbname
  read_capacity  = local.dbr
  write_capacity = local.dbw
  hash_key       = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}

resource "aws_s3_bucket" "terraform_backend" {
  bucket = local.s3name
}

resource "aws_s3_bucket_server_side_encryption_configuration" "example" {
  count  = local.s3e ? 1 : 0
  bucket = aws_s3_bucket.terraform_backend.bucket

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = local.kmsid
      sse_algorithm     = "aws:kms"
    }
  }
}