resource "aws_iam_role" "lambda_execution_role_20251029_182236" {
  name        = "lambda-execution-role_20251029_182236"
  description = "Execution role for lambda function"

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

resource "aws_iam_policy" "lambda_execution_policy_20251029_182236" {
  name        = "lambda-execution-policy_20251029_182236"
  description = "Policy for lambda execution role"

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
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_execution_policy_attachment_20251029_182236" {
  role       = aws_iam_role.lambda_execution_role_20251029_182236.name
  policy_arn = aws_iam_policy.lambda_execution_policy_20251029_182236.arn
}

resource "aws_lambda_function" "random_greeting_lambda_20251029_182236" {
  filename      = "lambda_function_payload_20251029_182236.zip"
  function_name = "random-greeting-lambda_20251029_182236"
  handler       = "index.handler"
  runtime       = "nodejs18.x"
  role          = aws_iam_role.lambda_execution_role_20251029_182236.arn
}

resource "aws_lambda_permission" "allow_test_invoke_20251029_182236" {
  statement_id  = "AllowTestInvoke_20251029_182236"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.random_greeting_lambda_20251029_182236.function_name
  principal     = "lambda.amazonaws.com"
}

resource "null_resource" "create_lambda_function_payload_20251029_182236" {
  provisioner "local-exec" {
    command = <<-EOF
      echo "exports.handler = async (event) => { const greetings = ['Hello', 'Hi', 'Hey']; const randomGreeting = greetings[Math.floor(Math.random() * greetings.length)]; console.log(randomGreeting); return { statusCode: 200, body: randomGreeting }; };" > index.js
      zip lambda_function_payload_20251029_182236.zip index.js
    EOF
  }
}

module "module_main" {
  source = "./modules/module_main"
}
