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
}
resource "aws_instance" "jenkins" {
  ami           = "ami-05c8ca4485f8b138a"
  instance_type = "t2.micro"
  key_name      = "test"
  userdata      = file("userdata.sh")
}
  tags = {
    Name = "slave01"
  }

