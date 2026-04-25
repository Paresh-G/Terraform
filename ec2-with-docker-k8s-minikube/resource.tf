resource "aws_instance" "my_kubectl_instance" {
  ami             = "ami-08e7318c2e031024c"
  instance_type   = "t3.small"
  key_name        = aws_key_pair.my_key_pair.key_name
  security_groups = [aws_security_group.my_kubectl_sg.name]
  tags = {
    Name = "my_kubectl_instance"
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("C:/Users/pares/Downloads/key/.ssh/id_rsa")
    host        = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",

      # Install basic tools
      "sudo yum install -y curl",
      "sudo yum install -y git",
      "sudo yum install -y tree",

      # Install Docker (Amazon Linux)
      "sudo yum install -y docker",
      "sudo systemctl enable --now docker",

      # Add user to docker group (won't reflect immediately)
      "sudo usermod -aG docker ec2-user",

      # Install kubectl
      "curl -LO https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl",
      "chmod +x kubectl",
      "sudo mv kubectl /usr/local/bin/",

      # Install minikube dependencies
      "sudo yum install -y conntrack",

      # Install minikube
      "curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64",
      "sudo install minikube-linux-amd64 /usr/local/bin/minikube",
      "rm minikube-linux-amd64",
      "sudo -u ec2-user minikube start --driver=docker"
    ]
  }
}

resource "aws_key_pair" "my_key_pair" {
  key_name   = "my_key_pair"
  public_key = file("C:/Users/pares/Downloads/key/.ssh/id_rsa.pub")
}

resource "aws_security_group" "my_kubectl_sg" {
  name        = "my_kubectl_security_group"
  description = "Allow SSH traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }
  /*ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  } */
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
