variable "server_name" {
  type = string
  default = "minecraft-server"
}

variable "minecraft_version" {
  type = string
  default = "latest"
}

variable "instance_subnet" {
  type = string
  default = ""
}

variable "instance_profile" {
  type = string
  default = "minecraft-server-role"
}

variable "instance_ssh_key" {
  type = string
  default = "minecraft-ssh"
}

variable "instance_type" {
  type = string
  default = "t3.medium"
}

variable "kms_key_id" {
  type = string
  default = ""
}

# Root volume
variable "instance_volume_type" {
  type = string
  default = "gp3"
}
variable "instance_volume_iops" {
  type = string
  default = 500
}
variable "instance_volume_size" {
  type = string
  default = 32
}
  # EBS data volume
variable "ebs_backups_enabled" {
  type = string
  default = false
}
variable "ebs_backups_frequency" {
  type = string
  default = null
}
variable "ebs_backups_lifespan" {
  type = string
  default = null
}
variable "ebs_restore_from_snapshot" {
  type = bool
  default = false
}
variable "ebs_snaphot_id" {
  type = string
  default = null
}

variable "ebs_volume_type" {
  type = string
  default = "gp3"
}
variable "ebs_volume_iops" {
  type = number
  default = 500
}
variable "ebs_volume_size" {
  type = number
  default = 500
}

variable "tags" {
  type = map(object({}))
  default = {}
}
