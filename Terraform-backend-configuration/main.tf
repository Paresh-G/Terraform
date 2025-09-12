terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "6.11.0"
    }
  }
  backend "s3" {                       //To store .tfstate file, we have initialize backend in aws s3
    bucket = "paresh-rg-test"          //The bucket name present in aws cloud
    key = "Dev/dev-terraform.tfstate"  //The folder and with the name of .tfstate file in s3 bucket 
    region = "ap-south-1"              //region where we are storing
    dynamodb_table = "my-test-table"   //dynamodb configuration
  }
}

provider "aws" {
  region = "ap-south-1"
}