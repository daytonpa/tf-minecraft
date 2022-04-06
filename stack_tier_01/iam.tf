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
}

data "aws_iam_policy_document" "minecraft_bastion_permissions_s3" {
  statement {
    sid = "IAMS3DataBucketBastionVpnFolder"
    effect = "Allow"
    actions = [
      "s3:ListBuckets"
      "s3:PutObject"
      "s3:ListObjects"
      "s3:GetObject"
    ]
    resources = [
      "${aws_s3_bucket.minecraft_data.arn}/data/vpn/*"
    ]
  }
  statement {
    sid = "IAMS3DataBucketBastionCommonFolder"
    effect = "Allow"
    actions = [
      "s3:ListBuckets"
      "s3:ListObjects"
      "s3:GetObject"
    ]
    resources = [
      "${aws_s3_bucket.minecraft_data.arn}/common/*"
    ]
  }
}

resource "aws_iam_policy_attachment" "minecraft_bastion_permissions_s3" {
  name = "minecraft_bastion_permissions_s3"
  roles = aws_iam_role.minecraft_bastion.name
  policy_arn = aws_iam_policy_document.minecraft_bastion_permissions_s3.arn
}

resource "aws_iam_policy" "minecraft_bastion_permissions_s3" {
  name        = "minecraft_bastion_permissions_s3"
  path        = "/"
  description = "A Policy for enabling S3 access to specific S3 Buckets and paths."
  policy      = data.aws_iam_policy_document.minecraft_bastion_permissions_s3.json
}

data "aws_iam_policy_document" "minecraft_bastion_permissions_s3" {
  statement {
    sid = "IAMS3DataBucketBastionVpnFolder"
    effect = "Allow"
    actions = [
      "s3:ListBuckets"
      "s3:PutObject"
      "s3:ListObjects"
      "s3:GetObject"
    ]
    resources = [
      "${aws_s3_bucket.minecraft_data.arn}/data/vpn/*"
    ]
  }
  statement {
    sid = "IAMS3DataBucketBastionCommonFolder"
    effect = "Allow"
    actions = [
      "s3:ListBuckets"
      "s3:ListObjects"
      "s3:GetObject"
    ]
    resources = [
      "${aws_s3_bucket.minecraft_data.arn}/common/*"
    ]
  }
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

data "aws_iam_policy_document" "kms_s3_policy" {
  statement {
    sid = "KmsPolicyS3Encyption"
    actions = [
      "kms:*"
    ]
    principals {
      type = "AWS"
      identifiers = ""
    }
  }
}
