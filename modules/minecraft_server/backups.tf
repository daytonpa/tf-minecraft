
resource "aws_dlm_lifecycle_policy" "minecraft_server_data" {
  description = "EBS backup policy for Minecraft server data"
  state = var.ebs_backups_enabled == true ? "ENABLED" : "DISABLED"

  policy_details {
    resource_types = ["VOLUME"]
    schedule {
      name = "${var.ebs_backups_lifespan} days of ${var.ebs_backups_frequency} EBS backups"
      copy_tags = true

      create_rule {
        interval = 24
        interval_units = "HOURS"
        times = ["23:45"]
      }
      retain_rule {
        count = var.ebs_backups_lifespan
      }
    }
    target_tags = {
      ebs_backups_enabled = "true"

    }
  }
}
