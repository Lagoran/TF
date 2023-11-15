output "first_arn" {
  value = values(aws_iam_user.example)[*].arn
}

output "all_users" {
  value = aws_iam_user.example
}
