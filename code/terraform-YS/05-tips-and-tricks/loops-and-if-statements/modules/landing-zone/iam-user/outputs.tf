output "user_arn" {
  value       = aws_iam_user.example.arn
  description = "The ARN of the created IAM user"
}

output "user_name" {
  value       = aws_iam_user.example.name
  description = "The NAME of the created IAM user"
}
