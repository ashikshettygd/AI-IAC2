resource "aws_iam_role" "iam_for_lambda_20251106_061103" {
  name = var.iam_role_name_20251106_061103

  assume_role_policy = jsonencode({
    Version   = "2012-10-17",
    Statement = [{
      Action    = "sts:AssumeRole",
      Effect    = "Allow",
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_logs_20251106_061103" {
  role       = aws_iam_role.iam_for_lambda_20251106_061103.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "null_resource" "create_lambda_zip_20251106_061103" {
  triggers = {
    always_run = timestamp()
  }

  provisioner "local-exec" {
    command = "mkdir -p ${path.module}/lambda_code && echo 'exports.handler = async (event) => { console.log(\"Hello, World!\"); };' > ${path.module}/lambda_code/index.js"
  }
}

resource "aws_lambda_function" "my_lambda_20251106_061103" {
  function_name = var.lambda_function_name_20251106_061103
  role          = aws_iam_role.iam_for_lambda_20251106_061103.arn

  filename         = data.archive_file.lambda_zip_20251106_061103.output_path
  source_code_hash = data.archive_file.lambda_zip_20251106_061103.output_base64sha256

  handler = "index.handler"
  runtime = "nodejs18.x"

  depends_on = [
    data.archive_file.lambda_zip_20251106_061103
  ]
}

module "s3_bucket_module_20251106_061103" {
  source      = "./modules/module_main"
  bucket_name = var.s3_bucket_name_20251106_061103
}
