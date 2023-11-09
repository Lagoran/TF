output "EC2_All_Attribute_Reference" {
  value       = aws_instance.example.*              #Adding all "Attribute refenrences according to documentation - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance"
  description = "The public IP address of the web server"
}
