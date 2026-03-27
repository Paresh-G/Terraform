resource "aws_vpc" "my-vpc" {
  cidr_block = var.vpc-cidr
  instance_tenancy = var.instance-tanancy
  tags = {
    Name = "my-vpc"
  }
}

resource "aws_internet_gateway" "my-igw" {
    depends_on = [ aws_vpc.my-vpc ]
    vpc_id = aws_vpc.my-vpc.id
    tags = {
        Name = "my-igw"
    }
}

resource "aws_subnet" "my-public-subnet" {
    depends_on = [ aws_vpc.my-vpc ]
  vpc_id     = aws_vpc.my-vpc.id
  cidr_block = var.public-subnet-cidr
  availability_zone = var.availability-zone
  map_public_ip_on_launch = true
  tags = {
    Name = "my-public-ssubnet"
  }
}

resource "aws_route_table" "my-public-rt" {
    depends_on = [ aws_internet_gateway.my-igw ]
    vpc_id = aws_vpc.my-vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.my-igw.id
    }
    tags = {
        Name = "my-public-rt"
    }
}

resource "aws_route_table_association" "my-public-association" {
    depends_on = [ aws_route_table.my-public-rt ]
  subnet_id = aws_subnet.my-public-subnet.id
  route_table_id = aws_route_table.my-public-rt.id
}