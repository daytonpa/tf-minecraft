
variable "instance_ami" {
  type = string
  description = "The Minecraft server AMI to use for creating the instance"
}
variable "instance_az" {
  type = string
  description = "The instance's AWS Availability Zone"
}
variable "instance_profile" {
  typeinstance_ami = string
  description = "The IAM profile ARN assigned to the instance"
}
variable "instance_ssh_key" {
  type = string
  description = "The SSH key used for OS access"
}
variable "instance_type" {
  type = string
  description = "The instance class of the Minecraft server."
  default = "m5.large"
}
variable "instance_volume_size" {
  type =  number
  description = "The capacity of the root volume (GB)"
  default = 20
}
variable "instance_volume_type" {
  type = string
  description = "gp3"
}
variable "instance_volume_iops" {
  type = number
  description = 500
}

variable "ebs_restore_from_snaphot" {
  type = bool
  description = ""
  default = false
}
variable "ebs_snapshot_id" {
  type = string
  description = ""
  default = null
}
variable "ebs_volume_iops" {
  type = number
  description = "Provioned IOPS for the EBS volume"
  default = 3000
}
variable "ebs_volume_size" {
  type = number
  description = "The capacity of the EBS volume (GB)"
  default = 60
}
variable "ebs_volume_type" {
  type = string
  description = "gp3"
}

variable "kms_key_id" {
  type = string
  description = "The ARN of the KMS key used for encryption"
}

variable "server_name" {
  type = string
  descrition = "minecraft-server"
}

variable "subnet_id" {
  type = string
  description = "The ID of the subnet where you'll generate the Minecraft server's network interface"
}