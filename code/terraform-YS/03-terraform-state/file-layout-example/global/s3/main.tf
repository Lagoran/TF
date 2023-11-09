#
#Before proceeding with setting up S3 for backend storage for the TF satte file
#please create the buclet and relaetd DynamoDb table from:
#"/home/ec2-user/Training/TF/code/terraform-YS/03-terraform-state/file-layout-example/s3-backend-prerequisite-step1"
#
terraform {
  required_version = ">= 1.0.0, < 2.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  # No variables are allowed in the backend definition
  backend "s3" {
    # Replace this with your bucket name!
    bucket         = "terraform-up-and-running-state-ys"
    key            = "global/s3/terraform.tfstate"
    region         = "us-east-1"
    access_key     = "AKIATMIA5QRTA7MQNHE3"
    secret_key     = "zISYnF+qzUGATdkoJTRBx5bN0W+lT6IA08Z314rB"
    

    # Replace this with your DynamoDB table name!
    dynamodb_table = "terraform_locks"
    encrypt        = true
  }      
}

provider "aws" {
  region = "us-east-1"

  access_key          = "AKIATMIA5QRTA7MQNHE3"
  secret_key          = "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"

}

# resource "aws_s3_bucket" "terraform_state" {

#   bucket = var.bucket_name

#   // This is only here so we can destroy the bucket as part of automated tests. You should not copy this for production
#   // usage
#   force_destroy = true

# }

# # Enable versioning so you can see the full revision history of your
# # state files
# resource "aws_s3_bucket_versioning" "enabled" {
#   bucket = aws_s3_bucket.terraform_state.id
#   versioning_configuration {
#     status = "Enabled"
#   }
# }

# # Enable server-side encryption by default
# resource "aws_s3_bucket_server_side_encryption_configuration" "default" {
#   bucket = aws_s3_bucket.terraform_state.id

#   rule {
#     apply_server_side_encryption_by_default {
#       sse_algorithm = "AES256"
#     }
#   }
# }

# # Explicitly block all public access to the S3 bucket
# resource "aws_s3_bucket_public_access_block" "public_access" {
#   bucket                  = aws_s3_bucket.terraform_state.id
#   block_public_acls       = true
#   block_public_policy     = true
#   ignore_public_acls      = true
#   restrict_public_buckets = true
# }

# resource "aws_dynamodb_table" "terraform_locks" {
#   name         = var.table_name
#   billing_mode = "PAY_PER_REQUEST"
#   hash_key     = "LockID"

#   attribute {
#     name = "LockID"
#     type = "S"
#   }
# }
