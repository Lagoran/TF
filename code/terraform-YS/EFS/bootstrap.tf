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

  access_key = "AKIARR5V7DDAYDMHLTNS"
  secret_key = "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"
}


# locals {
#   workspace_vars    = jsondecode(var.workspace_details)
#   aws_account_id    = local.workspace_vars["aws-account"]
#   region            = var.default_region
#   environment       = split("tfe-risk-efs-", terraform.workspace)[1]
# }
