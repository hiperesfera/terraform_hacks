provider "aws" {
  access_key = "AKTYTYTYTYUTYUTYUTYUTYUTYU"
  secret_key = "XXXXXXXXXXXXXXXXXX"
  region     = "eu-west-1"
}


# create a resource
resource "aws_vpc" "public" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default" 
  enable_dns_support   = "true" 
  enable_dns_hostnames = "true"

  # print anything from the local OS (files, env variables)
  provisioner "local-exec" {
    command = "echo $super_secret_variable"
  }
}


data "aws_caller_identity" "current" {}

output "aws-id" {
  value = "${data.aws_caller_identity.current.user_id}"
}

# print a file like .aws/credentials
data "local_file" "data" {
    filename = "./secrets.txt"
}

output "secret" {
  value = "${data.local_file.data}"
}
