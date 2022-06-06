terraform {
  required_version = ">= 0.14"

  backend "s3" {
    region = "us-east-1"
    bucket = "yauheni-paliakou-terraform-remote-state"
    key    = "security-group.tfstate"
    encrypt = "true"
  }
}
