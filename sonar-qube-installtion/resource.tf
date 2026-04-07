resource "aws_instance" "my_sonar_qube_instance" {
  ami             = "ami-0fe1d8d9040df33e6"
  instance_type   = "t2.small"
  key_name        = aws_key_pair.my_key_pair.key_name
  security_groups = [aws_security_group.my_sonar_qube_sg.name]
  tags = {
    Name = "my_sonar_qube_instance"
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
      "sudo yum install -y java-17-amazon-corretto.x86_64",
     // "sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo",
     // "sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key",
     // "sudo yum install -y jenkins",
     // "sudo systemctl enable --now jenkins",
      "sudo yum install -y git",
      "sudo wget https://dlcdn.apache.org/maven/maven-3/3.9.14/binaries/apache-maven-3.9.14-bin.tar.gz -O /opt/apache-maven-3.9.14-bin.tar.gz",
      "sudo tar -xzf /opt/apache-maven-3.9.14-bin.tar.gz -C /opt/",
      "sudo sleep 30",
      "echo 'export JAVA_HOME=/usr/lib/jvm/java-17-amazon-corretto.x86_64' >> ~/.bash_profile",
      "echo 'export M2_HOME=/opt/apache-maven-3.9.14' >> ~/.bash_profile",
      "echo 'export M2=$M2_HOME/bin' >> ~/.bash_profile",
      "echo 'export PATH=$PATH:$JAVA_HOME/bin:$M2_HOME/bin:$M2' >> ~/.bash_profile",
      "source ~/.bash_profile",
      "sudo sleep 30",
      "sudo wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-9.9.6.92038.zip -O /opt/sonarqube-9.9.6.92038.zip",
      "sudo unzip /opt/sonarqube-9.9.6.92038.zip -d /opt/",
      "sudo useradd sonaradmin || true",
      "sudo chown -R sonaradmin:sonaradmin /opt/sonarqube-9.9.6.92038",
      "sudo sysctl -w vm.max_map_count=262144",
      "sudo sysctl -w fs.file-max=65536",
      "sudo sleep 30",
      "sudo -u sonaradmin /opt/sonarqube-9.9.6.92038/bin/linux-x86-64/sonar.sh start"
    ]
  }
}

 resource "aws_key_pair" "my_key_pair" {
    key_name   = "my_key_pair"
    public_key = file("C:/Users/pares/Downloads/key/.ssh/id_rsa.pub")
  }

resource "aws_security_group" "my_sonar_qube_sg" {
  name        = "my_sonar_qube_security_group"
  description = "Allow SSH and 9000 traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }
  ingress {
    from_port   = 9000
    to_port     = 9000
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
