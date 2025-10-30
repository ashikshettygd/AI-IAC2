resource "aws_lambda_function" "lambda_function_20251030_083846" {
  filename      = "lambda_function_20251030_083846.zip"
  function_name = "lambda_function_20251030_083846"
  handler       = "index.handler"
  runtime       = "nodejs14.x"
  role          = "arn:aws:iam::123456789012:role/lambda-execution-role"

  depends_on = [null_resource.packaging_20251030_083846]
}

resource "null_resource" "packaging_20251030_083846" {
  provisioner "local-exec" {
    command = "zip lambda_function_20251030_083846.zip index.js"
  }
}
