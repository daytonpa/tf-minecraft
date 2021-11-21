# tf-minecraft

### About

Side project that uses Terraform to create AWS infrastructure that hosts a private Minecraft server behind a VPN. The Minecraft server is hosted in EC2 within a private subnet using EBS to store server data, and the server itself is configured using Chef Solo.

### Usage

Terraform templates are divided into 2 separate stacks:
  1) Restricted
    - Manages IAM roles/policies, overall VPC/network, S3 buckets and KMS keys.
  2) Base
    - VPN/bastion, Minecraft server, and instance-level Security Groups.

*(This is still in progress.  Would not recommend actually using just yet)*