terraform {
  backend "s3" {
    bucket = "terraform-state-bucket-20251024-011717"
    key    = "terraform.tfstate"
    region = "us-west-2"
  }
}
