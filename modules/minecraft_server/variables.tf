variable "instance_type" {
  type = string
  description = "The AWS instance clas to use for the Minecraft server"
}

variable "subnet_id" {
  type = string
  description = "The Subnet ID (private) to create the instance"
}

variable "server_name" {
  type = string
  default = "minecraft-server"
}
