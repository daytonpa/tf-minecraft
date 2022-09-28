variable "minecraft_servers" {
  description = "A map of Minecraft server options. Refer to the README for additional details."
  type = list(object({
    name                      = string
    minecraft_version         = string
    primary                   = bool
    instance_class            = string
    instance_os               = string
    instance_volume_type      = string
    instance_volume_iops      = number
    instance_volume_size      = number
    ebs_backups_enabled       = bool
    ebs_backups_frequency     = string
    ebs_backups_lifespan      = string
    ebs_restore_from_snapshot = bool
    ebs_volume_type           = string
    ebs_volume_iops           = number
    ebs_volume_size           = number
    tags                      = map(any)
  }))
  nullable = true
  default = [{
    name                      = "minecraft-server-main"
    minecraft_version         = "latest"
    primary                   = true
    instance_class            = "t3.medium"
    instance_os               = "ubuntu-22.04"
    instance_volume_type      = "gp3"
    instance_volume_iops      = 500
    instance_volume_size      = 32
    ebs_backups_enabled       = false
    ebs_backups_frequency     = null
    ebs_backups_lifespan      = null
    ebs_restore_from_snapshot = null
    ebs_volume_type           = "gp3"
    ebs_volume_iops           = 500
    ebs_volume_size           = 64
    tags = {
      "Name" : "minecraft-server-main",
      "Terraform" : "true"
    }
  }]
}

variable "region" {
  type    = string
  default = "us-east-2"
}

variable "profile" {
  type    = string
  default = "steve"
}
