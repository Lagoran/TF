terraform {
  required_version = ">= 1.0.0, < 2.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"

  access_key          = "AKIA2PPY223GPKDB25HF"
  secret_key          = "AaamDq1p0TQJasfmKZ6yBW425mxzorEERlaWpiky"

}


resource "aws_iam_user" "example" {
  count = 3

  name  = "${var.user_name_prefix}.${count.index}"
}
