terraform {
  required_version = ">= 1.0.0, < 2.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  ###Ignoring backend setup as it's failing due AWS error -  Error: error configuring S3 Backend: error validating provider credentials: error calling sts:GetCallerIdentity: ExpiredToken: The security token included in the request is expired!!!

  # # No variables are allowed in the backend definition
  # backend "s3" {
  #   # Replace this with your bucket name!
  #   bucket         = "terraform-up-and-running-state-ys"
  #   key            = "dev/services/webserver-cluster/terraform.tfstate"
  #   region         = "us-east-1"
  #   access_key     = "AKIAQ42FJ63UNVWZFHEQ"
  #   secret_key     = "XLOXuhVky7vIPk4byB66LpUP5Yck3odiUEcjAoNo"
    

  #   # Replace this with your DynamoDB table name!
  #   dynamodb_table = "terraform_locks"
  #   encrypt        = true
  # }      
}

provider "aws" {
  region = "us-east-1"

#AWS account credentials
  access_key = "AKIA4T3PQ7VVZ5NFJJZ5"
  secret_key = "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"

  default_tags {
    tags = {
      Owner    = "YS"
      ManagedBy= "Terraform"      
    }
  }
}
