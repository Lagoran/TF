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

  access_key = "AKIAQ5WABLEVABZNKHT4"
  secret_key = "3aXHkHbwkp1D6zudM0pB8yZHRdzatgZW4NVGcroH"
}

resource "aws_instance" "example" {
  ami                    = "ami-022e1a32d3f742bd8"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.instance.id]  # this is an TF expression example referencing another resource declared below

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p ${var.server_port} &
              EOF

  user_data_replace_on_change = true

  tags = {
    Name = "terraform-example-draft"
  }
}

resource "aws_security_group" "instance" {

  name = var.security_group_name

  ingress {
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
