resource "aws_s3_bucket" "example_20251029_180001" {
  bucket = "example-bucket-20251029-180001"
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
