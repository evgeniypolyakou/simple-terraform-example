variable "name" {}

variable "profile" {
  type        = string
  default     = "************"
  description = "Default Account ID"
}

variable "region" {
  type        = string
  default     = "us-east-1"
  description = "Default region"
}


 variable "public_subnets" {
  type        = list(any)
  description = "List of cidr_blocks of public subnets"
}


variable "private_subnets" {
  type        = list(any)
  description = "List of cidr_blocks of public subnets"
}

variable "tags" {
  
}
