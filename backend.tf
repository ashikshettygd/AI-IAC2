terraform {
  backend "s3" {
    bucket = "terraform-state-20251024-005028"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
