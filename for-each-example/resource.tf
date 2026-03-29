/*
locals {
    networks = {
  my_vpc1 = {
    vpc_cidr = "10.0.0.0/24"
    subnet_cidr = "10.0.0.0/28"
  }
  my_vpc2 = {
    vpc_cidr = "10.0.1.0/24"
    subnet_cidr = "10.0.1.0/28"
  }
    }
}

resource "aws_vpc" "my_vpc" {
    for_each = local.networks
    cidr_block = each.value.vpc_cidr
    tags = {
        Name = each.key
    }
}



resource "aws_subnet" "my_subnet" {
    depends_on = [ aws_vpc.my_vpc ]
    for_each = local.networks
    vpc_id = aws_vpc.my_vpc[each.key].id
    cidr_block = each.value.subnet_cidr
    tags = {
        Name = "${each.key}-subnet"
    }
  
}
*/

// OR // 

locals {
  inst_type = {
    staging = "t2.micro"
    dev     = "t2.small"
  }
}

resource "aws_instance" "my_linux" {
  for_each = local.inst_type
  ami      = "ami-0931307dcdc2a28c9"

  instance_type = each.value

  tags = {
    Environmet = each.key
  }
}
