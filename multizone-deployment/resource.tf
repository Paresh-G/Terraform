resource "aws_instance" "my-linux-inst-ap" {
  ami           = "ami-0931307dcdc2a28c9"
  instance_type = "t2.micro"
  provider = aws.ap
  tags = {
    Name = "My Linux Instance"
  } 
}

resource "aws_instance" "my-linux-inst-us" {
  ami           = "ami-0c3389a4fa5bddaad"
  instance_type = "t2.micro"
  provider = aws.us
  tags = {
    Name = "My Linux Instance"
  }
  
}