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
  description = "The AWS Region used for provisioning infrastructure"
  default = "us-east-1"
}

variable "region_alias" {
  type = string
  description = "The AWS Region, but tiny"
  default = "use1"
}

variable "primary_az" {
  type = string
  description = "The primary/active Availability Zone"
  default = "us-east-1b"
}

variable "recovery_az" {
  type = string
  description = "The recovery/passive Availability Zone"
  default = "us-east-1c"
}

variable "vpn_port" {
  type = number
  description = "The port used to connect to the VPN"
  default = 1234
}

variable "server_port" {
  type = number
  description = "The port used to connect to the Minecraft server"
  default = 44945
}
