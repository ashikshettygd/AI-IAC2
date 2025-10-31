variable "aws_region" {
  description = "The AWS region to create resources in."
  type        = string
  default     = "us-east-1"
}

variable "lambda_function_name" {
  description = "The name of the Lambda function."
  type        = string
  default     = "my-lambda-function-20251031-070908"
}

variable "iam_role_name" {
  description = "The name of the IAM role for the Lambda function."
  type        = string
  default     = "lambda_execution_role_20251031_070908"
}
