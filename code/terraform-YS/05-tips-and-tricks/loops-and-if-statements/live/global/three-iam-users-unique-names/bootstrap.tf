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

  access_key          = "AKIAVBA6PLUMWZ36DXPE"
  secret_key          = "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"

}
