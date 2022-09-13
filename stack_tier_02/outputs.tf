output "sg_minecraft_base_id" {
  value = module.minecraft_network_and_firewalls.sg_minecraft_base_id
}
output "sg_minecraft_server_id" {
  value = module.minecraft_network_and_firewalls.sg_minecraft_server_id
}
output "sg_minecraft_server_port" {
  value = var.minecraft_server_port
}
output "sg_minecraft_bastion_id" {
  value = module.minecraft_network_and_firewalls.sg_minecraft_bastion_id
}
output "sg_minecraft_bastion_port" {
  value = var.minecraft_bastion_port
}
output "kms_key_ebs_id" {
  value = aws_kms_key.ebs.id
}
output "kms_key_ssm_id" {
  value = aws_kms_key.ssm.id
}
output "ssh_key_name" {
  value = aws_key_pair.ssh.key_name
}
output "ssh_key_id" {
  value = aws_key_pair.ssh.id
}
