terraform {
  backend "s3" {
    bucket = "terraform-state-20251024-003824"
    key    = "terraform.tfstate"
    region = "us-west-2"
  }
}
