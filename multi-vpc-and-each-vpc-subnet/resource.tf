resource "aws_vpc" "my_vpc" {
    count = 2
    cidr_block = var.vpc_cidr[count.index]
    tags = {
      Name = "my_vpc-${count.index}"
    }
}

resource "aws_subnet" "my_subnet" {
    count = 2
    vpc_id = aws_vpc.my_vpc[count.index].id
    cidr_block = var.subnet_cidr[count.index]
    tags = {
        Name = "my_subnet-${count.index}"
    }
  
}