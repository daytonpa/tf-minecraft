locals {
  instance_ami = var.ami
  instance_az = var.availability_zone
  instance_profile = var.instance_profile
  instance_ssh_key = var.ssh_key
  instance_type = var.instance_type
  
  kms_key_id = var.kms_key_id

  minecraft_server_user_data  = templatefile(
    "user-data.sh.tpl",
    {
      minecraft_version = var.minecraft_version != null ? var.minecraft_version : "latest"
    }
  )

  ebs_restore_from_snaphot = var.restore_from_snaphot
  ebs_snapshot_id = var.snapshot_id

  subnet_id = var.subnet_id
}