provider "aws" {
  region  = var.aws_region
  profile = var.profile
}

module "terraform_backend" {
  source = "../modules/setup"

  backend_s3_bucket_name              = var.s3_bucket_name
  backend_s3_bucket_encrypt           = var.s3_bucket_encrypt
  backend_s3_bucket_encryption_key_id = var.s3_kms_key_id

  backend_dynamodb_table_name  = var.dynamodb_table_name
  backend_dynamodb_table_read  = var.dynamodb_table_read_capacity
  backend_dynamodb_table_write = var.dynamodb_table_write_capacity
}
