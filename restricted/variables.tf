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
}

variable "recovery_az" {
  type = string
  description = "The recovery/passive Availability Zone"
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
