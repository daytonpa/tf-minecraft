variable "region" {
  type        = string
  description = "The AWS Region used for provisioning infrastructure."
  default     = "us-east-1"
}
variable "region_alias" {
  type        = string
  description = "A shortend alias for the AWS Region."
  default     = "use1"
}
variable "profile" {
  type        = string
  description = "The AWS IAM user/profile used for provisioning infrastructure."
}

variable "s3_minecraft_data_bucket_name" {
  type        = string
  description = "S3 Bucket name for Minecraft stuff."
  default     = "minecraft-data"
}


variable "vpc_name" {
  type        = string
  description = "Name of the VPC."
  default     = "minecraft-vpc"
}
variable "vpc_cidr" {
  type        = string
  description = "A CIDR range for your VPC."
  default     = "10.0.0.0/26"
}
variable "vpc_availability_zones" {
  type        = list(string)
  description = "A list of Availbility Zones to use."
  default     = ["us-east-1a"]
}
variable "vpc_private_subnet_cidrs" {
  type        = list(string)
  description = "A list of CIDRs used for your Private Subnets."
  default     = ["10.0.0.0/27"]
}
variable "vpc_public_subnet_cidrs" {
  type        = list(string)
  description = "A list of CIDRs used for your Public Subnets."
  default     = ["10.0.0.32/27"]
}
variable "vpc_dns_enabled" {
  type        = bool
  description = "Enable DNS?"
  default     = false
}
variable "vpc_dns_support" {
  type        = bool
  description = "Enable DNS support?"
  default     = false
}

variable "ebs_kms_key_name" {
  type        = string
  description = "A name or identifier for KMS and EBS"
  default     = "minecraft-kms-ebs"
}
variable "s3_kms_key_name" {
  type        = string
  description = "A name or identifier for KMS and S3"
  default     = "minecraft-kms-s3"
}

variable "slava_ukraine" {
  type        = bool
  description = "You support Ukraine as a sovereign and independent nation with a democratically elected leader."
  default     = true
}
