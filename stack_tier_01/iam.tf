# ********** IAM **********

# Bastions/VPN
resource "aws_iam_instance_profile" "minecraft_bastion" {
  name = "minecraft-bastion-profile"
  role = aws_iam_role.minecraft_bastion.name
}

data "aws_iam_policy_document" "minecraft_bastion" {
  statement {
    sid = "IAMS3DataBucketBastionVpnFolder"
    effect = "Allow"
    actions = [
      "s3:ListBuckets",
      "s3:PutObject",
      "s3:ListObjects",
      "s3:GetObject"
    ]
    resources = [
      aws_s3_bucket.minecraft_data.arn,
      "${aws_s3_bucket.minecraft_data.arn}/data/vpn/*"
    ]
  }
  statement {
    sid = "IAMS3DataBucketBastionCommonFolder"
    effect = "Allow"
    actions = [
      "s3:ListBuckets",
      "s3:ListObjects",
      "s3:GetObject"
    ]
    resources = [
      "${aws_s3_bucket.minecraft_data.arn}/common/*"
    ]
  }
}
resource "aws_iam_policy" "minecraft_bastion" {
  name        = "minecraft-bastion-role"
  path        = "/"
  description = "A Policy for enabling S3 access to specific S3 Buckets and paths."
  policy      = data.aws_iam_policy_document.minecraft_bastion.json
}
resource "aws_iam_policy_attachment" "minecraft_bastion" {
  name = "minecraft-bastion-role"
  roles = [aws_iam_role.minecraft_bastion.name]
  policy_arn = aws_iam_policy.minecraft_bastion.arn
}
resource "aws_iam_role" "minecraft_bastion" {
  name = "minecraft-bastion-role"
  path = "/"

  assume_role_policy = <<POLICY
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
POLICY
}

# Minecraft server
resource "aws_iam_instance_profile" "minecraft_server" {
  name = "minecraft-server-profile"
  role = aws_iam_role.minecraft_server.name
}

data "aws_iam_policy_document" "minecraft_server" {
  statement {
    sid = "IAMS3DataBucketServerVpnFolder"
    effect = "Allow"
    actions = [
      "s3:ListBuckets",
      "s3:PutObject",
      "s3:ListObjects",
      "s3:GetObject"
    ]
    resources = [
      aws_s3_bucket.minecraft_data.arn,
      "${aws_s3_bucket.minecraft_data.arn}/data/vpn/*"
    ]
  }
  statement {
    sid = "IAMS3DataBucketServerCommonFolder"
    effect = "Allow"
    actions = [
      "s3:ListBuckets",
      "s3:ListObjects",
      "s3:GetObject"
    ]
    resources = [
      "${aws_s3_bucket.minecraft_data.arn}/common/*"
    ]
  }
}
resource "aws_iam_policy" "minecraft_server" {
  name        = "minecraft-server-role"
  path        = "/"
  description = "A Policy for enabling S3 access to specific S3 Buckets and paths."
  policy      = data.aws_iam_policy_document.minecraft_bastion.json
}
resource "aws_iam_policy_attachment" "minecraft_server" {
  name = "minecraft-server-role"
  roles = [aws_iam_role.minecraft_server.name]
  policy_arn = aws_iam_policy.minecraft_server.arn
}
resource "aws_iam_role" "minecraft_server" {
  name = "minecraft-server-role"
  path = "/"

  assume_role_policy = <<POLICY
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
POLICY
}

# Minecraft backup role
data "aws_iam_policy_document" "minecraft_backups" {
  statement {
    sid = "PlaceholderPolicyWillBeChanged"
    effect = "Allow"
    actions = [
      "s3:ListBuckets",
      "s3:ListObjects"
    ]
    resources = [
      "${aws_s3_bucket.minecraft_data.arn}/common/*"
    ]
  }
}
resource "aws_iam_policy" "minecraft_backups" {
  name        = "minecraft-backups-role"
  path        = "/"
  description = "A Policy for enabling S3 access to specific S3 Buckets and paths."
  policy      = data.aws_iam_policy_document.minecraft_backups.json
}
resource "aws_iam_policy_attachment" "minecraft_backups" {
  name = "minecraft-backups-role"
  roles = [aws_iam_role.minecraft_backups.name]
  policy_arn = aws_iam_policy.minecraft_backups.arn
}
resource "aws_iam_role" "minecraft_backups" {
  name = "minecraft-backups-role"
  path = "/"

  assume_role_policy = <<POLICY
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
POLICY
}
