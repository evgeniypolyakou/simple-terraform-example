provider "aws" {
  region  = var.region
  version = "3.74"

  /*assume_role {
    role_arn = var.role_arn
  }*/
  
}