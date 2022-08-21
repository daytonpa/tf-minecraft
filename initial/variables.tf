variable "aws_region" {
  type        = string
  description = "The AWS Region name"
}
variable "profile" {
  type        = string
  description = "Name of the profile in your AWS credentials file, '~/.aws/credentials"
}
variable "dynamodb_table_name" {
  type        = string
  description = "The name of the DynamoDB Table used for maintaing state locks"
}
variable "dynamodb_table_read_capacity" {
  type = string
}
variable "dynamodb_table_write_capacity" {
  type = string
}
variable "s3_bucket_name" {
  type = string
}
variable "s3_bucket_encrypt" {
  type = bool
}
variable "s3_kms_key_id" {
  type = string
}
