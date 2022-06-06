terraform {
  required_version = ">= 0.14"

  backend "s3" {
    region = "us-east-1"
    bucket = "yauheni-paliakou-terraform-remote-state"
    key    = "vpc.tfstate"
    #profile        = "397662559378"
    encrypt = "true"
  }
}