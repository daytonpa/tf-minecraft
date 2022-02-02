variable "aws_access_key" {
  type = string
  description = "The Access Key value for your AWS account"
}
variable "aws_secret_key" {
  type = string
  description = "The secret access key value for your AWS account"
}

variable "region" {
  type = string
  description = "AWS Region"
  default = "us-east-1"
}

variable "primary_az" {
  type = string
  description = "The primary AZ used to create infrastructure"
}

variable "recovery_az" {
  type = string
  description = "The recovery AZ used to create infrastructure"
}

variable "minecraft_servers" {
  type = map
  decription = "Details around the Minecraft server, or several"
}

variable "ebs_backups_enabled" {
  type = bool
  description = "Should backups be enabled"
  default = false
}
variable "ebs_backups_frequency" {
  type = number
  description = "The frequency which EBS data disk backups will be taken (in hours)"
  default = 24
} 
variable "ebs_backups_lifespan" {
  type = number
  description = "The number of snapshots that should be retained"
  default = 7
}