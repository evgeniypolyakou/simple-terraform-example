data "terraform_remote_state" "vpc" {
  backend   = "s3"
  workspace = terraform.workspace
  config = {
    bucket = "yauheni-paliakou-terraform-remote-state"
    key    = "vpc.tfstate"
    region = "us-east-1"
  }
}

data "terraform_remote_state" "security-group" {
  backend   = "s3"
  workspace = terraform.workspace
  config = {
    bucket = "yauheni-paliakou-terraform-remote-state"
    key    = "security-group.tfstate"
    region = "us-east-1"
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  owners = ["099720109477"]
}

locals {

  vpc_security_group_ids_bastion = [data.terraform_remote_state.security-group.outputs.security_group_id_bastion]
  vpc_security_group_ids_admin   = [data.terraform_remote_state.security-group.outputs.security_group_id_admin]
  subnet_id_pub                  = element(data.terraform_remote_state.vpc.outputs.public_subnets, 0)
  subnet_id_priv                 = element(data.terraform_remote_state.vpc.outputs.private_subnets, 0)
  availability_zone              = element(data.terraform_remote_state.vpc.outputs.azs, 0)

}

module "ssh_key_pair" {
  source = "cloudposse/key-pair/aws"

  stage                 = var.stage
  attributes            = ["key"]
  ssh_public_key_path   = "./secrets"
  generate_ssh_key      = "true"
  private_key_extension = ".pem"


}

module "ec2_instance_bastion" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "3.4.0"

  name = "${var.name}-bastion_host"


  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  availability_zone      = local.availability_zone
  subnet_id              = local.subnet_id_pub
  vpc_security_group_ids = local.vpc_security_group_ids_bastion
  key_name               = module.ssh_key_pair.key_name
  associate_public_ip_address = true

  tags = var.tags

}

module "ec2_instance_admin" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "3.4.0"

  name = "${var.name}-admin_host"


  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  availability_zone      = local.availability_zone
  subnet_id              = local.subnet_id_priv
  vpc_security_group_ids = local.vpc_security_group_ids_admin
  key_name               = module.ssh_key_pair.key_name

  associate_public_ip_address = false

  tags = var.tags

}

