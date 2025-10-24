terraform {
  backend "s3" {
    bucket = "terraform-state-bucket-20251024-012221"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
