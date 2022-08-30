variable "instance_type" {
  type = string
  description = "The AWS instance clas to use for the Minecraft server"
}

variable "subnet_id" {
  type = string
  description = "The Subnet ID (private) to create the instance"
}

variable "name_prefix" {
  type = string
  default = "minecraft-server"
}

variable "minecraft_servers" {
  type = list(map(
    name = string
    primary = bool
    instance_profile = string
    instance_class = string
    instance_volume_type = string
    instance_volume_iops = number
    instance_volume_size = number
    ebs_backups_enabled = bool
    ebs_backups_frequency = string
    ebs_backups_lifespan = string
    ebs_restore_from_snapshot = bool
    ebs_snaphot_id = string
    ebs_volume_type = string
    ebs_volume_iops = number
    ebs_volume_size = number
    tags = map()
  ))
  default = [
    {
      name = "minecraft-server"
      primary = true
      instance_profile = "minecraft-server-role"
      instance_class = "t3.medium"
      instance_volume_type = "gp3"
      instance_volume_iops = 500
      instance_volume_size = 32
      ebs_backups_enabled = false
      ebs_backups_frequency = null # "daily:12hr"
      ebs_backups_lifespan = null # "2w"
      ebs_restore_from_snapshot = false
      ebs_snaphot_id = null
      ebs_volume_type = "gp3"
      ebs_volume_iops = 500
      ebs_volume_size = 64
    }
  ]
}