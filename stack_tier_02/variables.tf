variable "region" {
  type = string
}
variable "profile" {
  type = string
}

variable "minecraft_server_port" {
  type = number
  default = 12345
}
variable "minecraft_bastion_port" {
  type = number
  default = 22
}
variable "minecraft_enabled_cidrs" {
  type = list(string)
  default = []
}
variable "admin_cidrs" {
  type = list(string)
  default = []
}