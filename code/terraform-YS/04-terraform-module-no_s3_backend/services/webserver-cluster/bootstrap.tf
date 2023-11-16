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
  access_key = "AKIAW3G4E226CGLBIFH4"
  secret_key = "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"

  default_tags {
    tags = {
      Owner    = "YS"
      ManagedBy= "Terraform"
    }
  }
}
