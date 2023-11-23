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

#AWS account credentials
  access_key = "AKIASTSYK6TWAE77DZZH"
  secret_key = "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"

  default_tags {
    tags = {
      Owner    = "YS"
      ManagedBy= "Terraform"      
    }
  }
}
