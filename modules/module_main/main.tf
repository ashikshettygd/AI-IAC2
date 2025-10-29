resource "aws_iam_role" "example_lambda_role_20251029_183108" {
  name        = "example_lambda_role_20251029_183108"
  description = "Example Lambda role"

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
