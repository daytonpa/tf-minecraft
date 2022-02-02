output "vpc_id" {
  value = module.minecraft_network.vpc_id
}
output "vpc_cidr" {
  value = module.minecraft_network.vpc_id
}
output "vpc_name" {
  value = module.minecraft_network.vpc_id
}

output "subnet_private_primary_id" {
  value = module.minecraft_network.subnet_private_primary_id
}
output "subnet_private_recovery_id" {
  value = module.minecraft_network.subnet_private_recovery_id
}
output "subnet_public_primary_id" {
  value = module.minecraft_network.subnet_public_primary_id
}
output "subnet_public_recovery_id" {
  value = module.minecraft_network.subnet_public_recovery_id
}

output "security_group_base_id" {
  value = module.minecraft_network.sg_base_id
}
output "security_group_bastion_id" {
  value = module.minecraft_network.sg_server_id
}
output "security_group_server_id" {
  value = module.minecraft_network.sg_bastion_id
}

output "aws_kms_key_arn" {
  value = aws_kms_key.encrypt.arn
}
output "aws_ssh_key_name" {
  value = aws_key_pair.ssh.name
}

output "iam_profile_server" {
  value = aws_iam_instance_profile.server.arn
}
output "iam_profile_bastion" {
  value = aws_iam_instance_profile.bastion.arn
}
