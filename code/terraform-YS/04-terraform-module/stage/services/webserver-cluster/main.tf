terraform {
  
# No variables are allowed in the backend definition
  backend "s3" {
    # Replace this with your bucket name!
    bucket         = "terraform-up-and-running-state-ys"
    key            = "stage/services/webserver-cluster/terraform.tfstate"
    region         = "us-east-1"
    access_key     = "AKIA3MUY343T5TGKW7N5"
    secret_key     = "h+GYIQswe59SQntyhS/LCgJLDfNCwLKiMi4U2mYe"
    

    # Replace this with your DynamoDB table name!
    dynamodb_table = "terraform_dynamo_tbl"
    encrypt        = true
  }  
}

provider "aws" {
  region = "us-east-1"

  access_key     = "AKIA3MUY343T5TGKW7N5"
  secret_key     = "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"  
}

module "webserver_cluster" {
  source = "../../../modules/services/webserver-cluster"

  cluster_name            = "webservers-stage"
  db_remote_state_bucket  = "terraform-up-and-running-state-ys"
  db_remote_state_key     = "stage/data-stores/mysql/terraform.tfstate"

  instance_type           = "t2.micro"
  min_size                = 2
  max_size                = 10
}

resource "aws_autoscaling_schedule" "scale_out_during_business_hours" {
  scheduled_action_name = "scale-out-during-business-hours"
  min_size              = 1
  max_size              = 5
  desired_capacity      = 1
  recurrence            = "0 9 * * *"

  autoscaling_group_name = module.webserver_cluster.asg_name
}

resource "aws_autoscaling_schedule" "scale_in_at_night" {
  scheduled_action_name = "scale-in-at-night"
  min_size              = 1
  max_size              = 3
  desired_capacity      = 1
  recurrence            = "0 17 * * *"

  autoscaling_group_name = module.webserver_cluster.asg_name
}
