provider "aws" {
  region = "eu-north-1"
}

resource "aws_key_pair" "ssh-key" {
  key_name   = "ssh-key"
  public_key = file("~/.ssh/ec2-ssh.pub")
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH, HTTP"
  
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # yeah, it's overpermissive
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

resource "aws_instance" "ec2tech" {
  ami           = "ami-01b1be742d950fb7f"
  instance_type = "t3.micro"

  key_name               = aws_key_pair.ssh-key.key_name
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  tags = {
    Name = "tech-task"
  }

  associate_public_ip_address = true
}

output "instance_ip" {
  description = "The public IP address of the EC2 instance"
  value       = aws_instance.ec2tech.public_ip
}