resource "aws_iam_role" "lambda_role_20251029_180537" {
  name        = "lambda_role_20251029_180537"
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

resource "aws_iam_policy" "lambda_policy_20251029_180537" {
  name        = "lambda_policy_20251029_180537"
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

resource "aws_iam_role_policy_attachment" "lambda_attach_20251029_180537" {
  role       = aws_iam_role.lambda_role_20251029_180537.name
  policy_arn = aws_iam_policy.lambda_policy_20251029_180537.arn
}

resource "aws_lambda_function" "lambda_function_20251029_180537" {
  filename      = "lambda_function_payload.zip"
  function_name = "lambda_function_20251029_180537"
  handler       = "index.handler"
  runtime       = "nodejs18.x"
  role          = aws_iam_role.lambda_role_20251029_180537.arn
}

resource "aws_lambda_permission" "allow_cloudwatch_20251029_180537" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action         = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_function_20251029_180537.function_name
  principal      = "events.amazonaws.com"
  source_arn     = aws_cloudwatch_event_rule.lambda_schedule_20251029_180537.arn
}

resource "aws_cloudwatch_event_rule" "lambda_schedule_20251029_180537" {
  name                = "lambda_schedule_20251029_180537"
  schedule_expression = "cron(45 18 * * ? *)"
}

resource "aws_cloudwatch_event_target" "lambda_target_20251029_180537" {
  rule      = aws_cloudwatch_event_rule.lambda_schedule_20251029_180537.name
  target_id = "lambda_function_20251029_180537"
  arn       = aws_lambda_function.lambda_function_20251029_180537.arn
}

resource "aws_ses_email_identity" "email_identity_20251029_180537" {
  email = "ashetty@griddynamics.com"
}

resource "aws_ses_configuration_set" "email_config_20251029_180537" {
  name = "email_config_20251029_180537"
}

resource "aws_ses_configuration_set_event_destination" "email_destination_20251029_180537" {
  configuration_set_name = aws_ses_configuration_set.email_config_20251029_180537.name
  event_destination_name = "email_destination_20251029_180537"
  enabled                = true
  matching_types         = ["bounce", "complaint", "delivery", "open", "click", "reject", "rendering_failure"]

  cloud_watch_destination {
    dimension_name  = "email_dimension_20251029_180537"
    dimension_value = "email_dimension_value_20251029_180537"
    default_value   = "default_value_20251029_180537"
  }
}

resource "aws_lambda_function" "lambda_function_updated_20251029_180537" {
  filename      = "lambda_function_payload.zip"
  function_name = "lambda_function_20251029_180537"
  handler       = "index.handler"
  runtime       = "nodejs18.x"
  role          = aws_iam_role.lambda_role_20251029_180537.arn

  depends_on = [null_resource.upload_lambda_payload_20251029_180537]
}

resource "null_resource" "upload_lambda_payload_20251029_180537" {
  provisioner "local-exec" {
    command = "zip lambda_function_payload.zip index.js"
  }
}
