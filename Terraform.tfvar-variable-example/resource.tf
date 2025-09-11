// aws vpc creation basic resource block (only creating vpc)
resource "aws_vpc" "aws_vpc_block" {
  cidr_block = var.vpc_cidr
  instance_tenancy = var.vpc_instance_tenancy
  tags = {
    "Name"  =  "my-test-vpc"
    "env"   =  "Dev"
  }
}

resource "aws_subnet" "aws_subnet_block" {
  depends_on = [ aws_vpc.aws_vpc_block ]       // due to this flag, So this resorce block wait until creation of above VPC
  vpc_id = aws_vpc.aws_vpc_block.id            // Refering above VPC_ID to create subnet
  cidr_block = var.subnet_cidr
  availability_zone = var.subnet_az
  tags = {
    "Name" = "my_public_subnet"
  }
}