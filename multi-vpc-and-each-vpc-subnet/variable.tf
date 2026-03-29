variable "vpc_cidr" {
  type = list(string)
  default = [ "10.0.0.0/24", "10.0.1.0/24" ]
}

variable "subnet_cidr" {
  type = list(string)
  default = [ "10.0.0.0/28", "10.0.1.0/28" ]
}