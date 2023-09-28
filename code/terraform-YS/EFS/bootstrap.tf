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

  access_key = "AKIAY4EEFFAQVKARWSBV"
  secret_key = "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"
}


# locals {
#   workspace_vars    = jsondecode(var.workspace_details)
#   aws_account_id    = local.workspace_vars["aws-account"]
#   region            = var.default_region
#   environment       = split("tfe-risk-efs-", terraform.workspace)[1]
# }
