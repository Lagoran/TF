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

  access_key = "AKIAQTDB4QXC5HH6M3MN"
  secret_key = "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"
}
resource "aws_s3_bucket" "terraform_state" {
  bucket = "terraform-up-and-running-state-ystra"

# Prevent accidental deletion of this s3 bucket
  lifecycle {
    prevent_destroy = true
  }
}

# Enable versionin so you can see full revision hostory of your state files

resource "aws_s3_bucket_versioning" "enabled" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}


# Enable server-side encryption by default
resource "aws_s3_bucket_server_side_encryption_configuration" "default" {
  bucket = aws_s3_bucket.terraform_state.id
  
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}


# Explicitely block all public access to s3 bucket
resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket                  = aws_s3_bucket.terraform_state.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_dynamodb_table" "terraform_locks" {
  name                    = "terraform_dynamo_tbl"
  billing_mode            = "PAY_PER_REQUEST"
  hash_key                = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
  
}
