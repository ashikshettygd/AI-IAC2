resource "aws_lambda_function" "example_lambda_20251029_183108" {
  filename      = "lambda_function_payload_20251029_183108.zip"
  function_name = "example_lambda_20251029_183108"
  handler       = "index.handler"
  runtime       = "nodejs14.x"
  role          = "arn:aws:iam::123456789012:role/example_lambda_role_20251029_183108"

  depends_on = [null_resource.packaging_20251029_183108]
}

resource "null_resource" "packaging_20251029_183108" {
  provisioner "local-exec" {
    command = "zip lambda_function_payload_20251029_183108.zip index.js"
  }
}

module "module_main" {
  source = "./modules/module_main"
}
