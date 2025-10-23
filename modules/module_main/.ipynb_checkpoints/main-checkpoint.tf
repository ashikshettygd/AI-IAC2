module "s3_bucket_module" {
  source = "../.."

  bucket_name = var.bucket_name
}
