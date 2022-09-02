locals {
  os_name          = split("-", var.instance_os)[0]
  os_version       = split("-", var.instance_os)[1]

  amazon_owner_id  = length(regexall("amazon", local.os_name)) > 0 ? "" : null
  centos_owner_id  = length(regexall("centos", local.os_name)) > 0 ? "" : null
  ubuntu_owner_id  = length(regexall("ubuntu", local.os_name)) > 0 ? "099720109477" : null
  aws_ami_owner_id = coalesce(
    local.amazon_owner_id,
    local.centos_owner_id,
    local.ubuntu_owner_id
  )

  instance_profile = var.instance_profile
  instance_ssh_key = var.instance_ssh_key
  instance_type    = var.instance_type
  
  kms_key_id = var.kms_key_id

  minecraft_server_user_data  = templatefile(
    "${path.module}/templates/user-data.sh.tpl",
    {
      minecraft_version = var.minecraft_version != null ? var.minecraft_version : "latest"
    }
  )

  ebs_restore_from_snaphot = var.ebs_backups_enabled
  ebs_snapshot_id = var.ebs_snaphot_id

  subnet_id = var.instance_subnet
}