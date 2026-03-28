provider"aws" {
  region = "ap-south-1"
}

module "ec2-instance" {
  source = "./modules/ec2"
  //you can pass variable values here e.g as below as per your requirement
  // instance-ami = "ami-0931307dcdc2a28c9"
  // instance-type = "t2.micro"
    // availability-zone = "ap-south-1a"
    // vpc-id = "vpc-0008bed57cfff2863"
    // subnet-id = "subnet-024da23b27b9d3c61"
}

