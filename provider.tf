provider "aws" {
  region                  = "us-east-1"
  access_key               = "${env.AWS_ACCESS_KEY_ID}"
  secret_key               = "${env.AWS_SECRET_ACCESS_KEY}"
  s3_force_path_style      = true
  skip_requesting_account_id = true
  skip_metadata_api_check = true
}
