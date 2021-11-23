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
  decription = "Details around the minecraft server, or several"
}