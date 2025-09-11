// All are i/p type variable where from user we are taking i/p during execution
variable "vpc_cidr" {
  type = string
  default = "10.10.0.0/24"  //only adding default value in i/p variable
}

variable "vpc_instance_tenancy" {
  type = string
  default = "default"     //only adding default value in i/p variable
}

variable "subnet_cidr" {
  type = string
  default = "10.10.0.0/24" //only adding default value in i/p variable
}

variable "subnet_az" {
  type = string
  default = "ap-south-1c"  //only adding default value in i/p variable
}