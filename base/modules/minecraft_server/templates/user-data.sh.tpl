#!/bin/bash

# update/upgrade apt
apt update -y
apt upgrade -y
apt install -y \
  unzip
  vim
  jq
  wget
  telnet

# install the aws cli
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# install chef-client
curl -L https://omnitruck.chef.io/install.sh | sudo bash
if [[ $? -eq 0 ]]; then
  echo -e "\nChef Infra Client installed\n"
else
  echo -e "\nChef Infra Client failed to install\n"
  exit 1
fi

# download the zipped chef-repo from S3 and unpack it
aws s3 cp s3://${var.aws_s3_bucket}/chef-repo.zip /var/tmp/chef-repo.zip --region ${var.aws_region}
unzip /var/tmp/chef-repo.zip -d /etc/chef/chef-repo

# configure the chef-client to run in solo mode
cat < /etc/chef/solo.rb >> EOF
chef_license 'accept'

solo true
cookbook_path '/etc/chef/chef-repo/cookbooks'
data_bag_path '/etc/chef/chef-repo/data_bags'
environment_path '/etc/chef/chef-repo/environments'
roles_path '/etc/chef/chef-repo/roles'

node_name '${var.node_name}'
environment '${var.environment}'
file_cache_path '/var/chef/cache'

log_level :${var.log_level}
interval 1800
EOF

# grant chef system user sudo permissions
echo '' >> /etc/sudoers

# run the chef-client to install the minecraft server
chef-solo \
  --config /etc/chef/solo.rb \
  --json-attributes /etc/chef/roles/solo_minecraft_server.json \
  --daemonize \
  > /var/log/chef-solo.log
