resource "aws_instance" "my-linux" {
  ami               = var.instance-ami
  instance_type     = var.instance-type
  availability_zone = var.availability-zone
  vpc_security_group_ids = [aws_security_group.my-sg.id]
  subnet_id = var.subnet-id
  associate_public_ip_address = true
  key_name = aws_key_pair.my-key.key_name
  tags = {
    Name = "my-linux"
  }
}

resource "aws_key_pair" "my-key" {
  key_name   = "my-key"
  public_key = file("C:/Users/pares/Downloads/key/.ssh/id_rsa.pub")
}

resource "aws_security_group" "my-sg" {
  name = "my-sg"
  description = "Allow SSH and HTTP traffic"
  vpc_id = var.vpc-id
    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

