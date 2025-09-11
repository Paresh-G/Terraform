// aws vpc creation basic resource block (only creating vpc)
resource "aws_vpc" "aws_vpc_block" {
  cidr_block = "10.10.0.0/24"
  instance_tenancy = "default"
  tags = {
    "Name"  =  "my-test-vpc"
    "env"   =  "Dev"
  }
}

resource "aws_subnet" "aws_subnet_block" {
  depends_on = [ aws_vpc.aws_vpc_block ]       // due to this flag, So this resorce block wait until creation of above VPC
  vpc_id = aws_vpc.aws_vpc_block.id            // Refering above VPC_ID to create subnet
  cidr_block = "10.10.0.0/24"
  availability_zone = "ap-south-1a"
  tags = {
    "Name" = "my_public_subnet"
  }
}