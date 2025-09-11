// All are i/p type variable where from user we are taking i/p during execution
variable "vpc_cidr_ranges" {
  type = list(string)                                       // declearing list type variable
  default = ["10.10.0.0/24","10.20.0.0/24","10.30.0.0/24"]  //only adding default value in i/p variable
}

variable "vpc_instance_tenancy" {
  type = string
  default = "default"     //only adding default value in i/p variable
}
