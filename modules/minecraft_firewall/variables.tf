variable "aws_region_shortname" {
  description = "The AWS Region, but tiny"
  type = string
  default = "use1"
}

variable "minecraft_vpc_id" {
  type = string
  description = "The ID of your VPC."
}

variable "minecraft_server_port" {
  description = "The port the Minecraft server is running on."
  type = string
}

variable "minecraft_bastion_port" {
  description = "The port used to connect to the Minecraft Bastion server."
  type = number
}

variable "minecraft_enabled_cidrs" {
  type = list(string)
  description = "A list of /32 CIDRs (you and friends!)."
}

variable "admin_cidrs" {
  type = list(string)
  description = "A list of /32 CIDRs (admins only!)."
}
