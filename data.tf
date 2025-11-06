data "aws_caller_identity" "current_20251106_061103" {}

data "aws_region" "current_20251106_061103" {}

data "archive_file" "lambda_zip_20251106_061103" {
  type        = "zip"
  source_dir  = "${path.module}/lambda_code"
  output_path = "${path.module}/lambda_function.zip"
  depends_on = [
    null_resource.create_lambda_zip_20251106_061103
  ]
}
