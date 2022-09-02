# tf-minecraft

### About

Side project that uses Terraform to create AWS infrastructure that hosts a private Minecraft server behind a VPN. The Minecraft server is hosted in EC2 within a private subnet using EBS to store server data, and the server itself is configured using Chef Solo.

### Usage

Terraform templates are divided into 4 separate stacks:
  1) `initial`
    - Sets up your remote backend in AWS for Terraform to store state files.
  2) `stack_tier_01`
    - IAM roles/policies
    - overall VPC/network
    - S3 buckets
    - KMS Keys for S3
  3) `stack_tier_02`
    - KMS Keys for EBS/SSM
    - SSH keys
    - SSM Parameter for private half of SSH key
    - Security Groups
  4) `stack_tier_03` 
    - VPN/bastion
    - Minecraft server
    - Minecraft server data-specific AWS Backups

*(This is still in progress.  Would not recommend actually using just yet)*

TO-DO List:
- [x] Create a stack for the remote backend
- [x] Create initial Stack 01 for staging
- [x] Create initial Stack 02 for staging
- [x] Create initial Stack 03 for staging
  - [x] Create Minecraft server EC2 module
- [ ] Test Minecraft server OS/User Data 
  - [ ] Test Minecraft Server connectivity
  - [ ] Update other resources as needed
- [ ] Update initial Stack 03 for staging
  - [ ] Create Minecraft VPN/bastion EC2 module
- [ ] Test Minecraft VPN/bastion OS/User Data
  - [ ] Test VPN/bastion connectivity
  - [ ] Test Minecraft Server connectivity from VPN/bastion
  - [ ] Update other resources as needed
- [ ] Add more to list as I do/test stuff...
