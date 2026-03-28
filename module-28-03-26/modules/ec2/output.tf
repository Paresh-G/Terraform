output "instance-public-ip" {
  value = aws_instance.my-linux.public_ip
}

output "instance-sg" {
  value = aws_security_group.my-sg.name
}