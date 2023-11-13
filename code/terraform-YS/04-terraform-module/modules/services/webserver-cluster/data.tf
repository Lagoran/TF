data "terraform_remote_state" "db" {
  backend = "s3"

  config = {
    bucket = var.db_remote_state_bucket
    key    = var.db_remote_state_key
    region = local.region
    access_key          = "AKIARIZLXQ7IMTIQGKQY"
    secret_key          = "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"    
  }
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}
