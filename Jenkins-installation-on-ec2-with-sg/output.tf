output "Jenkins_server_ip" {
  value = aws_instance.my_jenkins_instance.public_ip
}
