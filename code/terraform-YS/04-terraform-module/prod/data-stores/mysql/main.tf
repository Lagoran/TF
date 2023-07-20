terraform {
  required_version = ">= 1.0.0, < 2.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  # No variables are allowed in the backend definition
  backend "s3" {
    # Replace this with your bucket name!
    bucket         = "terraform-up-and-running-state-ystrahinov"
    key            = "prod/data-stores/mysql/terraform.tfstate"
    region         = "us-east-1"
    access_key     = "AKIARIZLXQ7IMTIQGKQY"
    secret_key     = "ERyyZFmZ69adGBurx6f8M+7fZSPn4uTIl8TnVnxr"
    

    # Replace this with your DynamoDB table name!
    dynamodb_table = "terraform_dynamo_tbl"
    encrypt        = true
  }      
}

provider "aws" {
  region = "us-east-1"

  access_key          = "AKIARIZLXQ7IMTIQGKQY"
  secret_key          = "ERyyZFmZ69adGBurx6f8M+7fZSPn4uTIl8TnVnxr"

}

resource "aws_db_instance" "example" {
  identifier_prefix   = "terraform-up-and-running"
  engine              = "mysql"
  allocated_storage   = 10
  instance_class      = "db.t2.micro"
  skip_final_snapshot = true

  db_name             = var.db_name

  username = var.db_username
  password = var.db_password
}
