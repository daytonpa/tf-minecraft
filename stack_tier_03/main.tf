

module "minecraft_server" {
  source = "../modules/minecraft_server"

  for_each = var.minecraft_servers

  server_name = each.value.name

  instance_subnet = each.value.primary == true ? data.aws_subnet.private_primary.id : data.aws_subnet.private_recovery.id
  instance_profile = "minecraft-server-role"
  instance_ssh_key = data.terraform_remote_state.stack_tier_02.ssh_key_name
  instance_type = each.value.instance_class

  kms_key_id = data.terraform_remote_state.stack_tier_02.kms_key_ebs_id

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

  tags = each.value.ebs_backups_enabled == true ? merge({
    "Name": each.value.name,
    "ebs_backups_enabled": each.value.ebs_backups_enabled,
    "ebs_backups_frequency": each.value.ebs_backups_frequency,
    "ebs_backups_lifespan": each.value.ebs_backups_lifespan
  }) : merge({
    "Name": each.value.name,
    "ebs_backups_enabled": var.ebs_backups_enabled
  })

  # lifecycle {
  #   ignore_changes = [instance_ami]
  # }
}

# resource "aws_instance" "vpn_bastion" {

#   for_each = var.bastion_servers

#   ami = data.aws_ami.latest_ubuntu.id
#   subnet_id = each.value.primary == true ? data.aws_subnet.public_primary.id : data.aws_subnet.public_recovery.id
#   iam_instance_profile = "minecraft-bastion-role"
#   instance_type = each.value.instance_class

#   key_name = data.aws_key_pair.server.name

#   network_interface {
#     network_interface_id = aws_network_interface.server.id
#   }

#   ebs_optimized = true
#   root_block_device {
#     delete_on_termination = true
#     encrypted = true
#     kms_key_id = data.aws_kms_key.encrypt.id
#     volume_type = each.value.instance_volume_type
#     volume_size = each.value.instance_volume_size
#   }

#   metadata_options {
#     http_endpoint = "enabled"
#     http_put_response_hop_limit = 1
#     http_token = "optional"
#   }

#   vpc_security_group_ids {

#   }

#   user_data = var.instance_user_data

#   tags {
#     merge(
#       local.global_tags,
#       Name = each.value
#     )
#   }
# }
