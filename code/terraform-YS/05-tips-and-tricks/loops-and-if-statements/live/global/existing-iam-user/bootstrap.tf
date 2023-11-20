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

  access_key          = "AKIARPLYHXCTI6TPRKWD"
  secret_key          = "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"

}
