output "vpc_id" {
  value = aws_vpc.main.id
}
output "vpc_cidr" {
  value = aws_vpc.main.cidr_block
}
output "vpc_name" {
  value = aws_vpc.main.name
}

output "subnet_private_primary_id" {
  value = aws_subnet.private_primary.id
}
output "subnet_private_recovery_id" {
  value = aws_subnet.private_recovery.id
}
output "subnet_public_primary_id" {
  value = aws_subnet.public_primary.id
}
output "subnet_public_recovery_id" {
  value = aws_subnet.public_recovery.id
}

output "sg_bastion_id" {
  value = aws_security_group.bastion.id
}
output "sg_server_id" {
  value = aws_security_group.server.id
}
output "sg_base_id" {
  value = aws_security_group.base.id
}