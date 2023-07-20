terraform {
  
# No variables are allowed in the backend definition
  backend "s3" {
    # Replace this with your bucket name!
    bucket         = "terraform-up-and-running-state-ystrahinov"
    key            = "prod/services/webserver-cluster/terraform.tfstate"
    region         = "us-east-1"
    access_key     = "AKIARIZLXQ7IMTIQGKQY"
    secret_key     = "ERyyZFmZ69adGBurx6f8M+7fZSPn4uTIl8TnVnxr"
    

    # Replace this with your DynamoDB table name!
    dynamodb_table = "terraform_dynamo_tbl"
    encrypt        = true
  }  
}

provider "aws" {
  region = "us-east-1"
}

module "webserver_cluster" {
  source = "../../../modules/services/webserver-cluster"

  cluster_name            = "webservers-prod"
  db_remote_state_bucket  = "terraform-up-and-running-state-ystrahinov"
  db_remote_state_key     = "prod/data-stores/mysql/terraform.tfstate"

  instance_type           = "m4.large"
  min_size                = 4
  max_size                = 10
}
