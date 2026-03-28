  variable "instance-ami" {
    type = string
    default = "ami-0931307dcdc2a28c9"
  }

  variable "instance-type" {
    type = string
    default = "t2.micro"
  }

  variable "availability-zone" {
    type = string
    default = "ap-south-1a"
  }

  variable "vpc-id" {
    type = string
    default = "vpc-0008bed57cfff2863"
  }

  variable "subnet-id" {
    type = string
    default = "subnet-024da23b27b9d3c61"
  }