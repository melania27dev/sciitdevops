terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = var.region
}

resource "aws_instance" "k3s" {
  ami                    = "ami-0084a47cc718c111a" # Ubuntu AMI
  instance_type          = "t3.micro"
  availability_zone      = var.public_subnet_az
  subnet_id              = aws_subnet.public-subnet.id
  vpc_security_group_ids = [aws_security_group.melania-sg.id]
 
  tags = merge(local.common_tags, { Name = "k3s" })
 
  user_data = file("apache.sh")
}

resource "aws_instance" "api" {
  ami                    = "ami-0084a47cc718c111a" # Ubuntu AMI
  instance_type          = "t3.micro"
  availability_zone      = var.public_subnet_az
  subnet_id              = aws_subnet.public-subnet.id
  vpc_security_group_ids = [aws_security_group.melania-sg.id]
 
  tags = merge(local.common_tags, { Name = "api" })
 
  user_data = file("apache.sh")
}
