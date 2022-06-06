data "terraform_remote_state" "vpc" { 
  backend = "s3"
  workspace = terraform.workspace
  config = {
    bucket = "yauheni-paliakou-terraform-remote-state"
    key    = "vpc.tfstate"
    region = "us-east-1"                  
  }
}

locals {

  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id

  subnet_id_pub = element(data.terraform_remote_state.vpc.outputs.public_subnets_cidr_blocks, 0)

}



module "security-group_bastion" {

  source  = "terraform-aws-modules/security-group/aws"
  version = "4.8.0"

  name    = "${var.name}-security-group-bastion_host"
  vpc_id  = local.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules = ["ssh-tcp"]

  
  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      description = "All egress"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

tags = var.tags

}

module "security-group_admin" {

  source  = "terraform-aws-modules/security-group/aws"
  version = "4.8.0"

  name    = "${var.name}-security-group-admin_host"
  vpc_id  = local.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules = ["http-80-tcp","https-443-tcp", "grafana-tcp"]

  ingress_with_cidr_blocks = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "User-service ports"
      cidr_blocks = local.subnet_id_pub
    }
  ]

  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      description = "All egress"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

tags = var.tags

}