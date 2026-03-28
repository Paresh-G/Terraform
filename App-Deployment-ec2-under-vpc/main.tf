terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 6.0"
    }
  }
}

provider "aws" {
    region = "ap-south-1"
}

/* make a note below before running code u have .tfvars file with below all variable value you need to pass inside .tfvar file

vpc-cidr="10.0.0.0/24"
instance-tanancy="default"
public-subnet-cidr="10.0.0.0/28"
availability-zone="ap-south-1a"
ami = "ami-0f559c3642608c138"
instance-type = "t2.micro"

*/

/* Also make a note before running these terraform code you have to generate ssh key pair
 and chnage accordingly in code and path,

 As well as you have to provide the path of the index.html page from you local.

 */
