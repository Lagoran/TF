resource "aws_launch_configuration" "example" {
  image_id            = "ami-022e1a32d3f742bd8"
  instance_type       = "t2.micro"
  security_groups     = [aws_security_group.instance.id]

  user_data           = templatefile("user-data.sh", {
    server_port       = var.server_port
    db_address        = data.terraform_remote_state.db.outputs.address
    db_port           = data.terraform_remote_state.db.outputs.port
  })
  
  
  ### Before amending the plainly inserted script with the above templatefile
  #   user_data = <<-EOF
  #           #!/bin/bash
  #           echo "Hello, World" > index.html
  #           echo "${data.terraform_remote_state.db.outputs.address}" >> index.html
  #           echo "${data.terraform_remote_state.db.outputs.port}" >> index.html
  #           nohup busybox httpd -f -p ${var.server_port} &
  #           EOF

  # Required when using a launch configuration with an auto scaling group
  lifecycle {
    create_before_destroy = true                                        #Every Terraform resource supports several lifecycle settings that configure how that resource is created, updated, and/or deleted. A particularly useful lifecycle setting is create_before_destroy. If you set create_before_destroy to true, Terraform will invert the order in which it replaces resources, creating the replacement resource first (including updating any references that were pointing at the old resource to point to the replacement) and then deleting the old resource. 
  }
}

resource "aws_autoscaling_group" "example" {
  launch_configuration  = aws_launch_configuration.example.name         #Note that the ASG uses a reference to fill in the launch configuration name. This leads to a problem: launch configurations are immutable, so if you change any parameter of your launch configuration, Terraform will try to replace it. Normally, when replacing a resource, Terraform would delete the old resource first and then creates its replacement, but because your ASG now has a reference to the old resource, Terraform won’t be able to delete it.
  vpc_zone_identifier   = data.aws_subnets.default.ids

  target_group_arns     = [aws_lb_target_group.asg.arn]                 #How does the target group know which EC2 Instances to send requests to? You could attach a static list of EC2 Instances to the target group using the aws_lb_target_group_attachment resource, but with an ASG, Instances can launch or terminate at any time, so a static list won’t work. Instead, you can take advantage of the first-class integration between the ASG and the ALB. Go back to the aws​_autoscaling_group resource, and set its target_group_arns argument to point at your new target group
  health_check_type     = "ELB"                                         #You should also update the health_check_type to "ELB". The default health_check_type is "EC2", which is a minimal health check that considers an Instance unhealthy only if the AWS hypervisor says the VM is completely down or unreachable. The "ELB" health check is more robust, because it instructs the ASG to use the target group’s health check to determine whether an Instance is healthy and to automatically replace Instances if the target group reports them as unhealthy. That way, Instances will be replaced not only if they are completely down but also if, for example, they’ve stopped serving requests because they ran out of memory or a critical process crashed.

  min_size = 2
  max_size = 10

  tag {
    key                 = "Name"
    value               = "terraform-asg-example"
    propagate_at_launch = true
  }
}

resource "aws_security_group" "instance" {
  name = var.instance_security_group_name

  ingress {
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#Deploying a Load Balancer
resource "aws_lb" "example" {
  name                  = var.alb_name
  load_balancer_type    = "application"
  subnets               = data.aws_subnets.default.ids
  security_groups       = [aws_security_group.alb.id]
}


#ALB part1 - Listener - Listens on a specific port (e.g., 80) and protocol (e.g., HTTP).
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.example.arn
  port              = 80
  protocol          = "HTTP"

  #By default, return a simpe 404

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "404: page not found"
      status_code  = 404
    }
  }
}

resource "aws_security_group" "alb" {
  name = var.alb_security_group_name

  # Allow inbound HTTP requests
  ingress {
    from_port     = 80
    to_port       = 80
    protocol      = "tcp"
    cidr_blocks   = ["0.0.0.0/0"]
  }

  #Allow all outbound requests
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


#ALB part 3 - Target groups  One or more servers that receive requests from the load balancer. The target group also performs health checks on these servers and sends requests only to healthy nodes.

resource "aws_lb_target_group" "asg" {

  name = var.alb_name

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


#ALB part 2 - Listener rule - The following code adds a listener rule that sends requests that match any path to the target group that contains your ASG.

resource "aws_lb_listener_rule" "asg" {
  listener_arn          = aws_lb_listener.http.arn
  priority              = 100

  condition {
    path_pattern {
      values            = ["*"]
    }
  }

  action {
    type                = "forward"
    target_group_arn    = aws_lb_target_group.asg.arn
  }
}
