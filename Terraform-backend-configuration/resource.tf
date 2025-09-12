resource "aws_vpc" "aws_vpc_block" {
  cidr_block = var.aws_vpc_cidr
  instance_tenancy = var.instance_tenancy
  tags = {
    "Name" = "my-test-vpc"
    "Env"  = "Dev"
  }
}

resource "aws_subnet" "aws_subnet_block" {
  depends_on = [ aws_vpc.aws_vpc_block ]
  vpc_id = aws_vpc.aws_vpc_block.id
  cidr_block = var.aws_subnet_cidr
  availability_zone = var.aws_subnet_az
  tags = {
    "Name" = "my-test-vpc-public-sub"
    "Env"  = "Dev"
  }
}