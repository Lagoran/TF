terraform {
  required_version = ">= 1.0.0, < 2.0.0"

# No variables are allowed in the backend definition
  # backend "s3" {
  #   # Replace this with your bucket name!
  #   bucket         = "terraform-up-and-running-state-ystrahinov"
  #   key            = "stage/services/webserver-cluster/terraform.tfstate"
  #   region         = "us-east-1"
  #   access_key     = "AKIARIZLXQ7IMTIQGKQY"
  #   secret_key     = "ERyyZFmZ69adGBurx6f8M+7fZSPn4uTIl8TnVnxr"
    

  #   # Replace this with your DynamoDB table name!
  #   dynamodb_table = "terraform_dynamo_tbl"
  #   encrypt        = true
  # }  
}

provider "aws" {
  region = local.region

  access_key          = var.access_key
  secret_key          = var.secret_key

}

resource "aws_launch_configuration" "example" {
  image_id            = "ami-022e1a32d3f742bd8"
  instance_type       = var.instance_type
  security_groups     = [aws_security_group.instance.id]

  # Render the User Data script as a template
  user_data = templatefile("${path.module}/user-data.sh", {
    server_port = var.server_port
    db_address  = data.terraform_remote_state.db.outputs.address
    db_port     = data.terraform_remote_state.db.outputs.port
  })

  # Required when using a launch configuration with an auto scaling group.
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "example" {
  launch_configuration = aws_launch_configuration.example.name
  vpc_zone_identifier  = data.aws_subnets.default.ids

  target_group_arns = [aws_lb_target_group.asg.arn]
  health_check_type = "ELB"

  min_size = var.min_size
  max_size = var.max_size

  tag {
    key                 = "Name"
    value               = "${var.cluster_name}-example"
    propagate_at_launch = true
  }
}

resource "aws_security_group" "instance" {
  name = "{var.cluster-name}-instance"

  ingress {
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = local.tcp_protocol
    cidr_blocks = local.all_ips
  }
}

resource "aws_lb" "example" {
  name               = "${var.cluster_name}-lb"
  load_balancer_type = "application"
  subnets            = data.aws_subnets.default.ids
  security_groups    = [aws_security_group.alb.id]
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.example.arn
  port              = local.http_port
  protocol          = "HTTP"

  # By default, return a simple 404 page
  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "404: page not found"
      status_code  = 404
    }
  }
}

resource "aws_lb_target_group" "asg" {
  name     = "${var.cluster_name}-trg-grp-asg"
  port     = var.server_port
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.default.id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 15
    timeout             = 3
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_listener_rule" "asg" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 100

  condition {
    path_pattern {
      values = ["*"]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.asg.arn
  }
}

resource "aws_security_group" "alb" {
  name = "${var.cluster_name}-alb"

  # # Allow inbound HTTP requests
  # ingress {
  #   from_port   = local.http_port
  #   to_port     = local.http_port
  #   protocol    = local.tcp_protocol
  #   cidr_blocks = local.all_ips
  # }

  # # Allow all outbound requests
  # egress {
  #   from_port   = local.any_port
  #   to_port     = local.any_port
  #   protocol    = local.any_protocol
  #   cidr_blocks = local.all_ips
  # }
}

resource "aws_security_group_rule "allow_http_inbound" {
  type              = "ingress"
  security_group_id = aws_security_group.alb.id
  
  from_port     = local.http_port
  to_port       = local_http_port
  protocol      = local.tcp_protocol
  cidr_block    = local.all_ips
}


resource "aws_security_group_rule "allow_all_outbound" {
  type              = "egress"
  security_group_id = aws_security_group.alb.id
  
  from_port      = local.any_port
  to_port        = local_any_port
  protocol       = local.any_protocol
  cidr_block     = local.all_ips
}
