output "lambda_function_arn_20251106_061103" {
  description = "The ARN of the Lambda function"
  value       = aws_lambda_function.my_lambda_20251106_061103.arn
}

output "iam_role_arn_20251106_061103" {
  description = "The ARN of the IAM role"
  value       = aws_iam_role.iam_for_lambda_20251106_061103.arn
}

output "s3_bucket_id_from_module_20251106_061103" {
  description = "The ID of the S3 bucket created by the module"
  value       = module.s3_bucket_module_20251106_061103.bucket_id
}
