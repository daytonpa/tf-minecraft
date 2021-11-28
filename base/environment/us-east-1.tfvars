
region = "us-east-1"

primary_az = "us-east-1b"
recovery_az = "us-east-1d"

minecraft_servers = {
  "minecraft-server-1": {
    "primary": true,
    "ebs_volume_type": "gp3",
    "ebs_volume_iops": 1000,
    "ebs_volume_size": 50,
    "ebs_restore_from_snapshot": false,

    "instance_class": "r6g.medium",
    "instance_volume_type": "gp3",
    "instance_volume_iops": 500,
    "instance_volume_size": 20,
  }
}

bastion_servers = {
  "minecraft-bastion-1": {
    "primary": true,

    "instance_class": "t3.small",
    "instance_volume_type": "gp3",
    "instance_volume_iops": 500,
    "instance_volume_size": 20
  }
}