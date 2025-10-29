data "archive_file" "lambda_payload_20251029_180537" {
  type        = "zip"
  source_file = "index.js"
  output_path = "lambda_function_payload.zip"
}
