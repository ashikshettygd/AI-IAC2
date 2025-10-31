output "lambda_function_arn" {
  description = "The ARN of the created Lambda function."
  value       = module.module_main_20251031_070908.lambda_arn
}

output "iam_role_arn" {
  description = "The ARN of the created IAM role."
  value       = module.module_main_20251031_070908.role_arn
}
