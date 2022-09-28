variable "server_name" {
  type    = string
  default = "minecraft-server"
}

variable "minecraft_version" {
  type    = string
  default = "latest"
}

variable "minecraft_server_port" {
  type    = number
  default = 12345
}

variable "instance_subnet" {
  type    = string
  default = ""
}

variable "instance_profile" {
  type    = string
  default = ""
}

variable "instance_ssh_key" {
  type    = string
  default = "minecraft-ssh"
}

variable "instance_type" {
  type    = string
  default = "t3.medium"
}

variable "instance_os" {
  type    = string
  default = "ubuntu-22.04"
  validation {
    condition     = length(regexall("^(amazon|centos|ubuntu)", split("-", var.instance_os)[0])) > 0
    error_message = <<-MESSAGE
  You may only use a supported OS. 
  - Refer to the README for supported operating systems and versions.
  - Example -> "ubuntu-22.04"

    MESSAGE
  }
}

variable "kms_key_id" {
  type    = string
  default = ""
}

# Root volume
variable "instance_volume_type" {
  type    = string
  default = "gp3"
}
variable "instance_volume_iops" {
  type    = string
  default = 500
}
variable "instance_volume_size" {
  type    = string
  default = 32
}
# EBS data volume
variable "ebs_backups_enabled" {
  type    = string
  default = false
}
variable "ebs_backups_frequency" {
  type    = string
  default = null
}
variable "ebs_backups_lifespan" {
  type    = string
  default = null
}
variable "ebs_backups_exec_role" {
  type    = string
  default = ""
}
variable "ebs_restore_from_snapshot" {
  type    = bool
  default = false
}
variable "ebs_snaphot_id" {
  type    = string
  default = null
}

variable "ebs_volume_type" {
  type    = string
  default = "gp3"
}
variable "ebs_volume_iops" {
  type    = number
  default = 500
}
variable "ebs_volume_size" {
  type    = number
  default = 500
}

variable "minecraft_server_sgs" {
  type    = list(any)
  default = ["default"]
}

variable "tags" {
  type    = map(any)
  default = {}
}
