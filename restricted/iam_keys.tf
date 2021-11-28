
# locals {
#   region_shortname = var.region == "us-east-1" ? "use1" : "use2"
# }

# Roles
resource "aws_iam_role" "server" {
  name = "minecraft-server-role"
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
      "Sid": "IamAssumeRole-${local.region_shortname}"
    },
    {
      "Sid": "S3GetAndListObjects"
      "Action": [
        "s3:ListBucket",
        "s3:GetObject",
        "s3:ListObject"
      ],
      "Effect": "Allow",
      "Resource" ["${aws_s3_bucket.minecraft.arn}/install/*"]
    },
    {
      "Sid": "S3BackupFilesToS3"
      "Action": [
        "s3:ListBucket",
        "s3:GetObject",
        "s3:ListObject",
        "s3:PutObject"
      ],
      "Effect": "Allow",
      "Resource" ["${aws_s3_bucket.minecraft.arn}/backups/*"]
    },
  ]
}
EOF
}

# Instance profiles

resource "aws_iam_instance_profile" "bastion" {
  name = "minecraft-server-profile"
  role = aws_iam_role.minecraft_bastion.name
}

resource "aws_iam_role" "minecraft_bastion" {
  name = "minecraft-server-role"
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
            "Sid": ""
        }
    ]
}
EOF
}

resource "aws_iam_instance_profile" "server" {
  name = "minecraft-server-profile"
  role = aws_iam_role.minecraft_server.name
}

# Keys
resource "aws_key_pair" "ssh" {
  key_name = "minecraft-ssh-key"
  public_key = var.public_key_material

  tags {
    Name = "minecraft-ssh-key"
  }
}