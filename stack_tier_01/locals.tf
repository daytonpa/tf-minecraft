locals {
  iam_minecraft_server = {
    s3_permissions = [
      "s3:GetAccessPoint",
      "s3:GetObject",
      "s3:GetObjectAttributes",
      "s3:GetObjectTagging",
      "s3:GetObjectVersion",
      "s3:ListBucket",
      "s3:ListBucketMultipartUploads",
      "s3:PutObject",
      "s3:PutObjectTagging",
      "s3:ReplicateTags"
    ]
    ecs_permissions = [
      "ecs:DescribeClusters",
      "ecs:DescribeServices",
      "ecs:DescribeTaskDefinitions",
      "ecs:DescribeTasks",
      "ecs:ListClusters",
      "ecs:ListServices",
      "ecs:ListTagsForResource",
      "ecs:ListTaskDefinitions",
      "ecs:ListTasks",
      "ecs:Poll",
    ]
  }
}