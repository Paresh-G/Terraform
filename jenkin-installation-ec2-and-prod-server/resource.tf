resource "aws_instance" "my_jenkins_instance" {
  ami             = "ami-0931307dcdc2a28c9"
  instance_type   = "t2.small"
  key_name        = aws_key_pair.my_key_pair.key_name
  security_groups = [aws_security_group.my_jenkins_sg.name]
  tags = {
    Name = "my_jenkins_instance"
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
      "sudo yum install -y java-21-amazon-corretto.x86_64",
      "sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo",
      "sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key",
      "sudo yum install -y jenkins",
      "sudo systemctl enable --now jenkins",
      "sudo yum install -y git",
      "sudo wget https://dlcdn.apache.org/maven/maven-3/3.9.14/binaries/apache-maven-3.9.14-bin.tar.gz -O /opt/apache-maven-3.9.14-bin.tar.gz",
      "sudo tar -xzf /opt/apache-maven-3.9.14-bin.tar.gz -C /opt/",
      "sudo sleep 30",
      "echo 'export JAVA_HOME=/usr/lib/jvm/java-21-amazon-corretto.x86_64' >> ~/.bash_profile",
      "echo 'export M2_HOME=/opt/apache-maven-3.9.14' >> ~/.bash_profile",
      "echo 'export M2=$M2_HOME/bin' >> ~/.bash_profile",
      "echo 'export PATH=$PATH:$JAVA_HOME/bin:$M2_HOME/bin:$M2' >> ~/.bash_profile",
      "source ~/.bash_profile"
    ]
  }
}

 resource "aws_key_pair" "my_key_pair" {
    key_name   = "my_key_pair"
    public_key = file("C:/Users/pares/Downloads/key/.ssh/id_rsa.pub")
  }

resource "aws_security_group" "my_jenkins_sg" {
  name        = "my_jenkins_security_group"
  description = "Allow SSH and 8080 traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }
  ingress {
    from_port   = 8080
    to_port     = 8080
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

resource "aws_instance" "my_prod" {
  ami = "ami-0931307dcdc2a28c9"
  instance_type = "t2.micro"
  key_name = aws_key_pair.my_key_pair.key_name
  security_groups = [aws_security_group.my_jenkins_sg.name]
  tags = {
    Name = "my_prod_instance"
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
      "sudo yum install -y java-21-amazon-corretto.x86_64",
    ]
  }

}