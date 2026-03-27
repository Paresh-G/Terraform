variable "vpc-cidr" {
  type = string
}

variable "public-subnet-cidr" {
    type = string
}

variable "availability-zone" {
    type = string
    default = "ap-south-1a"
}

variable "instance-tanancy" {
  type = string
}