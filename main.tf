resource "aws_iam_role" "lambda_exec_20251029_181313" {
  name        = "lambda_exec_20251029_181313"
  description = "Execution role for lambda"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Effect = "Allow"
      }
    ]
  })
}

resource "aws_iam_policy" "lambda_policy_20251029_181313" {
  name        = "lambda_policy_20251029_181313"
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
        Resource = "arn:aws:logs:*:*:*"
        Effect    = "Allow"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_attach_20251029_181313" {
  role       = aws_iam_role.lambda_exec_20251029_181313.name
  policy_arn = aws_iam_policy.lambda_policy_20251029_181313.arn
}

resource "aws_lambda_function" "greeting_lambda_20251029_181313" {
  filename      = "lambda_function_payload.zip"
  function_name = "greeting_lambda_20251029_181313"
  handler       = "index.handler"
  runtime       = "nodejs18.x"
  role          = aws_iam_role.lambda_exec_20251029_181313.arn
}

resource "aws_lambda_permission" "allow_invocation_20251029_181313" {
  statement_id  = "AllowInvocation"
  action         = "lambda:InvokeFunction"
  function_name = aws_lambda_function.greeting_lambda_20251029_181313.function_name
  principal      = "lambda.amazonaws.com"
}

resource "null_resource" "lambda_function_payload_20251029_181313" {
  provisioner "local-exec" {
    command = <<-EOF
      echo "exports.handler = async (event) => { console.log('Hello, World! ' + new Date().toISOString()); return { statusCode: 200 }; }; " > index.js
      zip lambda_function_payload.zip index.js
    EOF
  }
  depends_on = [aws_lambda_function.greeting_lambda_20251029_181313]
}
