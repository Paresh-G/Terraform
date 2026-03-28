output "vpc_id" {
  value = aws_vpc.my-vpc.id
}

output "vpc_cidr" {
  value = aws_vpc.my-vpc.cidr_block
}

output "vpc_zone" {
  value = aws_vpc.my-vpc.region
}

output "public_subnet_cidr" {
  value = aws_subnet.my-public-subnet.cidr_block
}

output "public_subnet_az" {
  value = aws_subnet.my-public-subnet.availability_zone
}

output "instance-public-ip" {
  value = aws_instance.my-linux-instance.public_ip
}

output "instance-private-ip" {
  value = aws_instance.my-linux-instance.private_ip
}