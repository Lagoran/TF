terraform {
  required_version = ">= 1.0.0, < 2.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"

  access_key          = "AKIA6IDCRNE3Q7OMOGUJ"
  secret_key          = "FOErvxK6Ikg/eY41StkIWTrQJW6BGRyIt6kIp2My"

}

resource "aws_iam_user" "existing_user" {
  # Make sure to update this to your own user name!
  name = "yevgeniy.brikman"
}
