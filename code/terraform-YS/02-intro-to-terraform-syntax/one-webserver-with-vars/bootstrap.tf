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
  access_key = "AKIA4T3PQ7VVZ5NFJJZ5"
  secret_key = "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"

  default_tags {
    tags = {
      Owner    = "YS"
      ManagedBy= "Terraform"      
    }
  }
}
