variable "backend_s3_bucket_name" {
  type = string
}
variable "backend_s3_bucket_encrypt" {
  type = string
}
variable "backend_s3_bucket_encryption_key_id" {
  type = string
}
variable "backend_dynamodb_table_name" {
  type = string
}
variable "backend_dynamodb_table_read" {
  type = number
}
variable "backend_dynamodb_table_write" {
  type = number
}
