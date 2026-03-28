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

resource "aws_security_group" "my-sg" {
  description = "Allow SSH and HTTP traffic for instances in my VPC"
  name = "my-linux-sg"
  vpc_id = aws_vpc.my-vpc.id
  tags = {
    Name = "my-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "sg-inbound-traffic-ssh" {
  security_group_id = aws_security_group.my-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "sg-inbound-traffic-http" {
  security_group_id = aws_security_group.my-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "sg-outbound-traffic" {
  security_group_id = aws_security_group.my-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 0
  to_port           = 0
  ip_protocol       = "-1"
}

resource "aws_key_pair" "my-key-pair" {
  key_name   = "my-key-pair"
  public_key = file("C:/Users/pares/Downloads/key/.ssh/id_rsa.pub")
}

resource "aws_instance" "my-linux-instance" {
  ami           = var.ami
  instance_type = var.instance-type
  subnet_id = aws_subnet.my-public-subnet.id
  vpc_security_group_ids = [aws_security_group.my-sg.id]
  key_name = aws_key_pair.my-key-pair.key_name
  tags = {
    Name = "my-linux-instance"
  }


  connection {
        type    = "ssh"
        user        = "ec2-user"  # Replace with the appropriate username for your EC2 instance
        private_key = file("C:/Users/pares/Downloads/key/.ssh/id_rsa")  # Replace with the path to your private key
        host        = self.public_ip # Use the public IP of the instance for SSH connection
  }

    # File provisioner to copy a file from local to the remote EC2 instance
  provisioner "file" {
    source      = "C:/Users/pares/Downloads/aws/index.html"  # Replace with the path to your local file
    destination = "/tmp/index.html"  # Replace with the path on the remote instance
  }

  provisioner "remote-exec" {
        inline = [
            "sudo yum update -y",
            "sudo yum install -y httpd",
            "sudo systemctl start httpd",
            "sudo systemctl enable httpd",
            "sudo mv /tmp/index.html /var/www/html/index.html"
        ]
  }
}

