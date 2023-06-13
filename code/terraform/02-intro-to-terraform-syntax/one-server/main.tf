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

  access_key = "AKIAU4ALRGXA24CQAUXM"
  secret_key = "diXOoPYuPEBSUqfOntxI7QPCOcjqZmLPgzAG0h77"
}

resource "aws_instance" "example" {
  ami           = "ami-022e1a32d3f742bd8"
  instance_type = "t2.micro"

  tags = {
    Name = "terraform-example"
  }
}

