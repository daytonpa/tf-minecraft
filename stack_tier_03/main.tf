

module "minecraft_server" {
  source = "../modules/minecraft_server"

  for_each = { for server in var.minecraft_servers: server.name => server }

  server_name = each.value.name
  minecraft_version = each.value.minecraft_version

  instance_os = each.value.instance_os
  instance_subnet = each.value.primary == true ? local.primary_subnet_id : local.recovery_subnet_id
  instance_profile = "minecraft-server-role"
  instance_ssh_key = data.terraform_remote_state.stack_tier_02.outputs.ssh_key_name
  instance_type = each.value.instance_class

  kms_key_id = data.terraform_remote_state.stack_tier_02.outputs.kms_key_ebs_id

  # Root volume
  instance_volume_type = each.value.instance_volume_type
  instance_volume_iops = each.value.instance_volume_iops
  instance_volume_size = each.value.instance_volume_size

  # EBS data volume
  ebs_volume_type = each.value.ebs_volume_type
  ebs_volume_iops = each.value.ebs_volume_iops
  ebs_volume_size = each.value.ebs_volume_size
  
  # ebs_restore_from_backup = false

  ebs_backups_enabled    = each.value.ebs_backups_enabled
  ebs_backups_frequency  = each.value.ebs_backups_frequency
  ebs_backups_lifespan   = each.value.ebs_backups_lifespan
  ebs_backups_exec_role  = data.terraform_remote_state.stack_tier_01.outputs.iam_arns.roles["minecraft-backups-role"]

  # ebs_restore_from_snapshot = each.value.ebs_restore_from_snapshot
  minecraft_server_sgs = [
    data.terraform_remote_state.stack_tier_02.outputs.sg_minecraft_base_id,
    data.terraform_remote_state.stack_tier_02.outputs.sg_minecraft_server_id,
  ]    
  # ebs_snaphot_id = each.value.ebs_snaphot_

  tags = each.value.ebs_backups_enabled == true ? {
    "Name": each.value.name,
    "ebs_backups_enabled": "true",
    "ebs_backups_frequency": each.value.ebs_backups_frequency,
    "ebs_backups_lifespan": each.value.ebs_backups_lifespan
  } : {
    "Name": each.value.name,
    "ebs_backups_enabled": "false"
  }

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
