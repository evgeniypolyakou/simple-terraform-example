variable "instance_type" {
  type        = string
  description = "The type of the instance"
  default     = "t2.micro"
}


variable "region" {
  type        = string
  description = "AWS Region the instance is launched in"
  default     = "us-east-1"
}

variable "name" {
  type        = string
  description = "Name of enviroment stage"
}

variable "tags" {
  
}

variable "stage" {
  
}