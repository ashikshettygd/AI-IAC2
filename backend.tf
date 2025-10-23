terraform {
  backend "s3" {
    bucket = "terraform-state-20251024-012915"
    key    = "terraform.tfstate"
    region = "us-west-2"
  }
}
