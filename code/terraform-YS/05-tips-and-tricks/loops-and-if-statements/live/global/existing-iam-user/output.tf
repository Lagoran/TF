output "AWS_STS" {
  value = data.aws_caller_identity.id[*]
}
