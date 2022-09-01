variable "minecraft_servers" {
  description = "A map of Minecraft server options. Refer to the README for additional details."
  type = list(object({
    name = string,
    primary = bool,
    instance_class = string,
    instance_volume_type = string,
    instance_volume_iops = number,
    instance_volume_size = number,
    ebs_backups_enabled = bool,
    ebs_backups_frequency = string,
    ebs_backups_lifespan = string,
    ebs_restore_from_snapshot = bool,
    ebs_volume_type = string,
    ebs_volume_iops = number,
    ebs_volume_size = number,
    tags = map(any)
  }))
}

variable "region" {
  type = string
  default = "us-east-2"
}

variable "profile" {
  type = string
  default = "steve"
}
