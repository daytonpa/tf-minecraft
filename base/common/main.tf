

module "minecraft_server" "main" {

  for_each = var.minecraft_servers

  server_name = each.key

  instance_ami = data.aws_ami.latest_ubuntu.id
  instance_subnet = each.value.primary == true ? data.aws_subnet.private_primary.id : data.aws_subnet.private_recovery.id
  instance_profile = "minecraft-server-role"
  instance_ssh_key = data.aws_key_pair.server.name
  instance_type = each.value.instance_class

  kms_key_id = data.aws_kms_key.encrypt.id

  # Root volume
  instance_volume_type = each.value.instance_volume_type
  instance_volume_iops = each.value.instance_volume_iops
  instance_volume_size = each.value.instance_volume_size

  # EBS data volume
  ebs_backups_enabled = each.value.ebs_backups_enabled
  ebs_backups_frequency = each.value.ebs_backups_frequency
  ebs_backups_lifespan = each.value.ebs_backups_lifespan
  ebs_restore_from_snapshot = each.value.ebs_restore_from_snapshot
  ebs_snaphot_id = each.value.ebs_snaphot_id
  ebs_volume_type = each.value.ebs_volume_type
  ebs_volume_iops = each.value.ebs_volume_iops
  ebs_volume_size = each.value.ebs_volume_size

  tags = merge(
    local.global_tags,
    "Name": each.key,
    "ebs_backups_enabled": var.ebs_backups_enabled,
    "ebs_backups_frequency": var.ebs_backups_frequency,
    "ebs_backups_lifespan": var.ebs_backups_lifespan
  )

  lifecycle {
    ignore_changes = [instance_ami, tags]
  }
}

module "minecraft_vpn" "main" {


}