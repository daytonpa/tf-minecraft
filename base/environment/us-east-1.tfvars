
region = "us-east-1"

primary_az = "us-east-1b"
recovery_az = "us-east-1d"

minecraft_servers = {
  {
    "primary": true,
    "ebs_volume_type": "gp3",
    "ebs_volume_iops": 3000,
    "ebs_volume_size": 50,
    "ebs_restore_from_snapshot": false,
    "ebs_snapshot_id": null,
    "instance_class": "r6g.medium",
    "instance_volume_type": "gp3",
    "instance_volume_iops": 500,
    "instance_volume_size": 20,
  }
}

bastion_servers = {
  {
    "primary": true,
    "instance_class": "r6g.medium",
    "instance_volume_type": "gp3",
    "instance_volume_iops": 500,
    "instance_volume_size": 20
  }
}