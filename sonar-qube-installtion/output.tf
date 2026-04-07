output "ec2_public_ip" {
  value = aws_instance.my_sonar_qube_instance.public_ip
}