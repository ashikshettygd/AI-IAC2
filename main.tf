resource "aws_s3_bucket" "s3_bucket_20251024_010840" {
  bucket = "s3-bucket-20251024-010840"
  acl    = "private"

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}
