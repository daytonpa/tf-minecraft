variable "aws_region_shortname" {
  description = "The AWS Region, but tiny"
  type = string
  default = "use1"
}

variable "minecraft_server_port" {
  description = "The port the Minecraft server is running on."
  type = string
  default = 12345
}

variable "minecraft_vpn_port" {
  description = "The port used to connect to the Minecraft VPN."
  type = string
  default = 12345
}