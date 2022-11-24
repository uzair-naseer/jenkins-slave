resource "aws_security_group" "project_sg" {
  name        = "sec-grp"
  description = "allow htttp and ssh trafic via terraform"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

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
  tags = {
    Name = "slave01"
  }
}
resource "aws_instance" "jenkins" {
  ami             = "ami-05c8ca4485f8b138a"
  instance_type   = "t2.micro"
  key_name        = "test"
    provisioner "remote-exec" {
    inline  = [
      "sudo yum install -y jenkins java-11-openjdk-devel",
      "sudo yum -y install wget",
      "sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo",
      "sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key",
      "sudo yum upgrade -y",
      "sudo yum install jenkins -y",
      "sudo systemctl start jenkins",
      ]
}
    connection {
    type         = "ssh"
    host         = self.public_ip
    user         = "ec2-user"
    agent        = false
    private_key  = $file"{/home/ec2-user/privatekey.pem}"  
    
}
