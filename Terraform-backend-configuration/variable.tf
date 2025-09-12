variable "aws_vpc_cidr" {
  type = string
  default = "10.10.0.0/24"
}

variable "instance_tenancy" {
  type = string
  default = "default"
}

variable "aws_subnet_cidr" {
  type = string
  default = "10.10.0.0/26"
}

variable "aws_subnet_az" {
  type = string
  default = "ap-south-1a"
}