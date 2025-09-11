// S3 bucket creation basic resource block
resource "aws_s3_bucket" "aws_s3_bucket_block" {  
  bucket = "paresh-rg-tf-bucket"
  tags = {
    "Name"        = "my-test-bucket"
    "env" = "Dev"
  }
}

// aws vpc creation basic resource block (only creating vpc)
resource "aws_vpc" "aws_vpc_block" {
  cidr_block = "10.10.0.0/24"
  instance_tenancy = "default"
  tags = {
    "Name"  =  "my-test-vpc"
    "env"   =  "Dev"
  }
}