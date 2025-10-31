data "archive_file" "lambda_zip_20251031_070908" {
  type        = "zip"
  source_file = "${path.module}/lambda_function.py"
  output_path = "${path.module}/lambda_function.zip"
}

resource "aws_iam_role" "iam_for_lambda_20251031_070908" {
  name = var.iam_role_name

  assume_role_policy = jsonencode({
    Version   = "2012-10-17",
    Statement = [
      {
        Action    = "sts:AssumeRole",
        Effect    = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_logs_20251031_070908" {
  role       = aws_iam_role.iam_for_lambda_20251031_070908.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_lambda_function" "lambda_function_20251031_070908" {
  function_name    = var.lambda_function_name
  role             = aws_iam_role.iam_for_lambda_20251031_070908.arn
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.8"
  filename         = data.archive_file.lambda_zip_20251031_070908.output_path
  source_code_hash = data.archive_file.lambda_zip_20251031_070908.output_base64sha256

  depends_on = [
    aws_iam_role_policy_attachment.lambda_logs_20251031_070908,
    data.archive_file.lambda_zip_20251031_070908
  ]
}
