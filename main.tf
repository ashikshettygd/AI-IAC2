### main.tf
module "module_main" {
  source = "./modules/module_main"
}

### variables.tf
variable "region" {
  type        = string
  default     = "us-east-1"
}

variable "lambda_function_payload" {
  type        = string
  default     = "lambda_function_payload.zip"
}

variable "lambda_handler" {
  type        = string
  default     = "index.handler"
}

variable "lambda_runtime" {
  type        = string
  default     = "nodejs18.x"
}

variable "email_identity" {
  type        = string
  default     = "ashetty@griddynamics.com"
}

variable "email_template_name" {
  type        = string
  default     = "email-template_20251029_180854"
}

variable "email_template_html" {
  type        = string
  default     = "<h1>Hello from Terraform!</h1>"
}

variable "email_template_subject" {
  type        = string
  default     = "Greetings from Terraform"
}

variable "email_template_text" {
  type        = string
  default     = "Hello from Terraform!"
}

### outputs.tf
# No outputs defined

### provider.tf
provider "aws" {
  region = var.region
}

### terraform.tfvars
# No variables defined

### versions.tf
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0.0"
    }
  }
}

### data.tf
# No data sources defined

### backend.tf
terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}

### modules/module_main/main.tf
resource "aws_iam_role" "lambda_exec_20251029_180854" {
  name        = "lambda-exec-role_20251029_180854"
  description = "Execution role for lambda"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "lambda_exec_policy_20251029_180854" {
  name        = "lambda-exec-policy_20251029_180854"
  description = "Policy for lambda execution"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
        ]
        Effect = "Allow"
        Resource = "arn:aws:logs:*:*:*"
      },
      {
        Action = [
          "ses:SendEmail",
          "ses:SendRawEmail",
        ]
        Effect = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_exec_attach_20251029_180854" {
  role       = aws_iam_role.lambda_exec_20251029_180854.name
  policy_arn = aws_iam_policy.lambda_exec_policy_20251029_180854.arn
}

resource "aws_lambda_function" "email_sender_20251029_180854" {
  filename      = var.lambda_function_payload
  function_name = "email-sender_20251029_180854"
  handler       = var.lambda_handler
  runtime       = var.lambda_runtime
  role          = aws_iam_role.lambda_exec_20251029_180854.arn
}

resource "aws_lambda_permission" "allow_cloudwatch_20251029_180854" {
  statement_id  = "AllowExecutionFromCloudWatch_20251029_180854"
  action         = "lambda:InvokeFunction"
  function_name = aws_lambda_function.email_sender_20251029_180854.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.daily_20251029_180854.arn
}

resource "aws_cloudwatch_event_rule" "daily_20251029_180854" {
  name                = "daily-event-rule_20251029_180854"
  schedule_expression = "cron(45 17 * * ? *)"
}

resource "aws_cloudwatch_event_target" "lambda_target_20251029_180854" {
  rule      = aws_cloudwatch_event_rule.daily_20251029_180854.name
  target_id = "lambda-target_20251029_180854"
  arn       = aws_lambda_function.email_sender_20251029_180854.arn
}

resource "aws_sesv2_configuration_set" "email_config_20251029_180854" {
  configuration_set_name = "email-config_20251029_180854"
}

resource "aws_sesv2_email_identity" "email_identity_20251029_180854" {
  email_identity = var.email_identity
}

resource "aws_sesv2_email_template" "email_template_20251029_180854" {
  template_name = var.email_template_name
  html_part      = var.email_template_html
  subject_part   = var.email_template_subject
  text_part      = var.email_template_text
}

resource "aws_lambda_function" "lambda_function_20251029_180854" {
  filename      = var.lambda_function_payload
  function_name = "lambda-function_20251029_180854"
  handler       = var.lambda_handler
  runtime       = var.lambda_runtime
  role          = aws_iam_role.lambda_exec_20251029_180854.arn
}

resource "aws_sesv2_event_destination" "event_destination_20251029_180854" {
  configuration_set_name = aws_sesv2_configuration_set.email_config_20251029_180854.configuration_set_name
  event_destination_name = "event-destination_20251029_180854"
  matching_types        = ["bounce", "complaint"]
  enabled                = true

  cloud_watch_destination {
    dimension_name  = "dimension-name"
    dimension_value = "dimension-value"
    default_value    = "default-value"
  }
}

### modules/module_main/variables.tf
variable "region" {
  type        = string
}

variable "lambda_function_payload" {
  type        = string
}

variable "lambda_handler" {
  type        = string
}

variable "lambda_runtime" {
  type        = string
}

variable "email_identity" {
  type        = string
}

variable "email_template_name" {
  type        = string
}

variable "email_template_html" {
  type        = string
}

variable "email_template_subject" {
  type        = string
}

variable "email_template_text" {
  type        = string
}

### modules/module_main/outputs.tf
# No outputs defined
