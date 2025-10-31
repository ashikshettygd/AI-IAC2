output "lambda_arn" {
  description = "The ARN of the Lambda function."
  value       = aws_lambda_function.lambda_function_20251031_070908.arn
}

output "role_arn" {
  description = "The ARN of the IAM role."
  value       = aws_iam_role.iam_for_lambda_20251031_070908.arn
}
