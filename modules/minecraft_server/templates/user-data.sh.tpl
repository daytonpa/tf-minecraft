#!/bin/bash
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

set -e

LOG_FILE=/var/log/user-data.log

echo -e "\n[$(date)] INFO: Starting User Data script.\n"
sudo yum update -y
sudo yum install -y \
  aws-cli \
  awslogs \
  ecs-init \
  jq \
  vim 

echo -e "\n[$(date)] INFO: Configuring ECS Agent for instance.\n"

echo "ECS_CLUSTER=${cluster_name}"  > /etc/ecs/ecs.config
echo "ECS_LOGFILE=${log_file_path}" >> /etc/ecs/ecs.config
echo "ECS_LOGLEVEL=${log_level}"    >> /etc/ecs/ecs.config
echo "ECS_LOG_OUTPUT_FORMAT=logfmt" >> /etc/ecs/ecs.config

echo -e "\n[$(date)] INFO: Starting Minecraft server disk setup (kinda...).\n"
mkdir -p /opt/minecraft/data

echo -e "\n[$(date)] INFO: User data completed."
