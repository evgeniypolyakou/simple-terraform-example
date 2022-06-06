module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.12.0"

  name = var.name
  azs             = ["us-east-1c"]
  cidr            = "10.0.0.0/16"
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets


  enable_nat_gateway = false

  tags = var.tags

}