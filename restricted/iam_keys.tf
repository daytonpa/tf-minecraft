resource "aws_iam_imstance_profile" "minecraft_bastion" {
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

resource "aws_iam_imstance_profile" "minecraft_server" {
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