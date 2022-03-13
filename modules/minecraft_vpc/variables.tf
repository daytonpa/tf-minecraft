variable "aws_region" {
  description = "The AWS Region"
  type = string
  default = "us-east-1"
}

variable "aws_region_shortname" {
  description = "The AWS Region, but tiny"
  type = string
  default = "use1"
}

variable "vpc_cidr" {
  description = "The full CIDR range for your Minecraft network"
  type = string
  default = "10.2.3.0/24"
}

variable "vpc_subnets" {
  description = "A JSON layout of your network"
  type = map
  default = {
    "10.2.3.0/28": {
      "az": "us-east-1a",
      "av": "private"
    },
    "10.2.3.24/28": {
      "az": "us-east1-1a"
      "av": "public"
    }
  }
}