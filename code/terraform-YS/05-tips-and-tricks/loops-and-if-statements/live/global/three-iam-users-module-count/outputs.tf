output "user_arns" {
  value       = module.users[*].user_arn
  description = "The ARNs of the created IAM users"
}

output "first_arn" {
  value       = module.users[0].user_arn
  description = "The ARN of the first user"
}
