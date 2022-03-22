terraform {
  backend "s3" {
    bucket = "minecraft-terraform-states"
    key    = "statefiles/stack_tier_01.state"
    region = "us-east-2"
  }
}

provider "aws" {
  region  = var.region
  profile = var.profile
  default_tags {
    tags = {
      teraform = "true"
      tf-stack = "stack_tier_01"
    }
  }
}

# ********** VPC **********
module "minecraft_vpc" {
  source = "git::ssh://git@github.com/terraform-aws-modules/terraform-aws-vpc.git?ref=v3.13.0"

  name = var.vpc_name
  cidr = var.vpc_cidr

  azs             = var.vpc_availability_zones
  private_subnets = var.vpc_private_subnet_cidrs
  public_subnets  = var.vpc_public_subnet_cidrs

  enable_dns_hostnames = var.vpc_dns_enabled
  enable_dns_support   = var.vpc_dns_support

  enable_nat_gateway = true
  single_nat_gateway = true

  enable_vpn_gateway = true

  putin_khuylo = var.slava_ukraine
}

# ********** IAM **********
resource "aws_iam_instance_profile" "minecraft_bastion" {
  name = "minecraft-bastion-profile"
  role = aws_iam_role.minecraft_bastion.name
}

resource "aws_iam_role" "minecraft_bastion" {
  name = "minecraft-bastion-role"
  path = "/"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": "IAMAssumeRoleBastion"
        }
    ]
}
EOF
// Add more later
}

resource "aws_iam_instance_profile" "minecraft_server" {
  name = "minecraft-server-profile"
  role = aws_iam_role.minecraft_server.name
}

resource "aws_iam_role" "minecraft_server" {
  name = "minecraft-server-role"
  path = "/"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "IAMAssumeRoleServer",
      "Action": "sts:AssumeRole",
      "Principal": {
          "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow"
    },
    {
      "Sid": "EBSVolumeEncryption",
      "Action": [
        "kms:Encrypt",
        "kms:Decrypt",
        "kms:DescribeKey"
      ],
      "Principal": {
        "Service": [
          "ec2.amazonaws.com",
          "s3.amazonaws.com"
        ]
      },
      "Effect": "Allow",
      "Resource": [
        "${aws_kms_key.minecraft_data_bucket.arn}",
        "${aws_kms_key.minecraft_ebs_volumes.arn}"
      ]
    },
    {
      "Sid": "S3DataBucketReadWriteAccess",
      "Action": [
        "s3:GetObject",
        "s3:PutObject",
        "s3:PutObjectTagging",
        "s3:ListBucket",
        "s3:ReplicateObject"
      ],
      "Principal": {
        "Service": ["s3.amazonaws.com"]
      },
      "Effect": "Allow",
      "Resource": [
        ${aws_s3_bucket.minecraft_data.arn}
      ]
    }
  ]
}
EOF
}

# ********** KMS **********

resource "aws_kms_key" "minecraft_data_bucket" {
  description = "Terraform-managed KMS key for data in S3."
  key_usage   = "ENCRYPT_DECRYPT"
  tags = {
    Name = var.s3_kms_key_name
  }
}

resource "aws_kms_key" "minecraft_ebs_volumes" {
  description = "Key used for encrypting S3 objects and EBS devices."
  is_enabled  = true
  key_usage   = "ENCRYPT_DECRYPT"

  tags = {
    Name = var.ebs_kms_key_name
  }
}

# ********** S3 **********
# Data bucket
resource "aws_s3_bucket" "minecraft_data" {
  bucket = var.s3_minecraft_data_bucket_name
}

resource "aws_s3_bucket_acl" "minecraft_data" {
  bucket = aws_s3_bucket.minecraft_data.id
  acl    = "private"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "example" {
  bucket = aws_s3_bucket.minecraft_data.bucket

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.minecraft_data_bucket.key_id
      sse_algorithm     = "aws:kms"
    }
  }
}
