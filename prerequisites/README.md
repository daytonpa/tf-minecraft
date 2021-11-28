## tf-minecraft Prerequisites

You'll need to create the following items by hand before starting your TF stack creation.  Each step comes with full details/guides with content you can copy/paste into your AWS account.  Should only take a few minutes to complete, then we're good to go

***

### Steps

1) Create an AWS `root` account

-) Create a Private S3 bucket to be used to store your Terrraform stack's statefile

-) Create a DynamoDB table for your TF code backend
  - I recommend using the same name for your DynamoDB table asyour S3 bucket.  Makes it easier to track/reference.

-) Create an IAM profile for your TF templates to use.  It'll need a lot of permissions.  The needed JSON can be found in this file
  - terraform_iam_permissions.json

3) 