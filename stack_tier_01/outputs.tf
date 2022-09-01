output "kms_ebs_id" {
  value = aws_kms_key.minecraft_ebs_volumes.id
}
output "kms_s3_id" {
  value = aws_kms_key.minecraft_data_bucket.id
}

output "iam_arns" {
  value = {
    "profiles": {
      "minecraft-bastion-profile": "${aws_iam_instance_profile.minecraft_bastion.arn}",
      "minecraft-server-profile": "${aws_iam_instance_profile.minecraft_server.arn}",
    },
    "roles": {
      "minecraft-backups-role": "${aws_iam_role.minecraft_backups.arn}",
      "minecraft-bastion-role": "${aws_iam_role.minecraft_bastion.arn}",
      "minecraft-server-role": "${aws_iam_role.minecraft_server.arn}",
    }
  }
}

output "s3_data_bucket_name" {
  value = aws_s3_bucket.minecraft_data.id
}
output "s3_data_bucket_arn" {
  value = aws_s3_bucket.minecraft_data.arn
}

# VPC details
output "vpc_id" {
  value = module.minecraft_vpc.vpc_id
}
output "vpc_name" {
  value = var.vpc_name
}
output "vpc_cidr_block" {
  value = module.minecraft_vpc.vpc_cidr_block
}
output "public_subnet_ids" {
  value = module.minecraft_vpc.public_subnets
}
output "private_subnet_ids" {
  value = module.minecraft_vpc.private_subnets
}