output "kubectl_instance_public_ip" {
  value = aws_instance.my_kubectl_instance.public_ip
}