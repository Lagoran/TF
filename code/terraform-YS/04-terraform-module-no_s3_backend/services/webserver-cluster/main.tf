module "webserver_cluster" {
  source                        = "../../modules/services/webserver-clusters"

  cluster_name            = "webservers-stage"
  
  instance_type           = "t2.micro"
  min_size                = 2
  max_size                = 10
  enable_autoscaling      = true

  custom_tags = {
    Owner     = "team-foo"
    ManagedBy = "terraform"
  }
}

resource "aws_autoscaling_schedule" "scale_out_during_business_hours" {
  count = var.enable_autoscaling ? 1 : 0

  scheduled_action_name = "scale-out-during-business-hours"
  min_size              = 1
  max_size              = 5
  desired_capacity      = 1
  recurrence            = "0 9 * * *"

  autoscaling_group_name = module.webserver_cluster.asg_name
}

resource "aws_autoscaling_schedule" "scale_in_at_night" {
  count = var.enable_autoscaling ? 1 : 0

  scheduled_action_name = "scale-in-at-night"
  min_size              = 1
  max_size              = 3
  desired_capacity      = 1
  recurrence            = "0 17 * * *"

  autoscaling_group_name = module.webserver_cluster.asg_name
}
