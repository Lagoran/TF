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

  access_key          = "AKIA2PPY223GPKDB25HF"
  secret_key          = "AaamDq1p0TQJasfmKZ6yBW425mxzorEERlaWpiky"

}
resource "aws_iam_user" "example" {
  count = length(var.user_names)
  name  = var.user_names[count.index]
}

resource "aws_iam_policy" "cloudwatch_read_only" {

  name   = "${var.policy_name_prefix}cloudwatch-read-only"

  policy = data.aws_iam_policy_document.cloudwatch_read_only.json
}

resource "aws_iam_policy" "cloudwatch_full_access" {

  name   = "${var.policy_name_prefix}cloudwatch-full-access"

  policy = data.aws_iam_policy_document.cloudwatch_full_access.json
}

resource "aws_iam_user_policy_attachment" "neo_cloudwatch_full_access" {
  count = var.give_neo_cloudwatch_full_access ? 1 : 0

  user       = aws_iam_user.example[0].name
  policy_arn = aws_iam_policy.cloudwatch_full_access.arn
}

resource "aws_iam_user_policy_attachment" "neo_cloudwatch_read_only" {
  count = var.give_neo_cloudwatch_full_access ? 0 : 1

  user       = aws_iam_user.example[0].name
  policy_arn = aws_iam_policy.cloudwatch_read_only.arn
}
