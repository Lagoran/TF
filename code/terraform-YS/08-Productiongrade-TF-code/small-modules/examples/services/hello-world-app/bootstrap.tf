terraform {
  required_version = ">= 1.0.0, < 2.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  ###Ignoring backend setup as it's failing due AWS error -  Error: error configuring S3 Backend: error validating provider credentials: error calling sts:GetCallerIdentity: ExpiredToken: The security token included in the request is expired!!!
}

provider "aws" {
  region = "us-east-1"

  #AWS account credentials
  access_key = "AKIA2MG7Q3IZGKTVQ3Q3"
  secret_key = "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"

  default_tags {
    tags = {
      Owner    = "YS"
      ManagedBy= "Terraform"
    }
  }
}
