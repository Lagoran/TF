terraform {
  
# No variables are allowed in the backend definition
  backend "s3" {
    # Replace this with your bucket name!
    bucket         = "terraform-up-and-running-state-ystrahinov"
    key            = "stage/services/webserver-cluster/terraform.tfstate"
    region         = "us-east-1"
    access_key     = "AKIAWZHTONJS6DUY365F"
    secret_key     = "W+XejrRotutGVAJEZsk6bFvoy68zZXI/5H+OFir+"
    

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
  #D:\Training\TF\terraform-up-and-running-code\code\terraform-YS\04-terraform-module\modules\services\webserver-cluster
  #D:\Training\TF\terraform-up-and-running-code\code\terraform-YS\04-terraform-module\stage\services\webserver-cluster
}
