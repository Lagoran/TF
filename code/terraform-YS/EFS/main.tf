resource "aws_instance" "example" {
  ami                    = "ami-022e1a32d3f742bd8"
  instance_type          = "t2.micro"
  key_name               = "my-key-pair"
  vpc_security_group_ids = [aws_security_group.instance.id,local.default_security_group_id]

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p ${var.server_port} &
              # sudo yum update -y
              # sudo yum install -y openssh-server
              # sudo systemctl start sshd
              # sudo systemctl enable sshd
              # sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
              # sudo systemctl restart sshd
              EOF

  user_data_replace_on_change = true

  tags = {
    Name = "terraform-example"
  }
}

resource "aws_key_pair" "my-key-pair" {
  key_name   = "my-key-pair"
  public_key = file("~/.ssh/id_rsa.pub")
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
