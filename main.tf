terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1" # Região Estados Unidos - Norte da Virgínia
}

resource "aws_security_group" "allow_ssh_http" {
    name        = "allow_ssh_http"
    description = "Allow SSH and HTTP traffic"
    vpc_id      = ""

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port   = 80
        to_port     = 80
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

# ===== Instância EC2 =====
resource "aws_instance" "this" {
  ami                         = "ami-08982f1c5bf93d976"
  instance_type               = "t2.micro"
  security_groups = [aws_security_group.allow_ssh_http.name]

  tags = { 
    Name = "demo-ec2"
  }
}