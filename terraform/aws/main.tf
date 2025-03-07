provider "aws" {
  region = var.region
}

resource "aws_instance" "k3s" {
  ami                    = "ami-0084a47cc718c111a" # Ubuntu AMI
  instance_type          = "t3.micro"
  availability_zone      = var.public_subnet_az
  subnet_id = aws_subnet.public-subnet.id
  vpc_security_group_ids = [aws_security_group.melania-sg.id]
 
  tags = merge(local.common_tags, { Name = "k3s" })
 
  user_data = file("apache.sh")
}

resource "aws_instance" "API" {
  ami                    = "ami-0084a47cc718c111a" # Ubuntu AMI
  instance_type          = "t3.micro"
  availability_zone      = var.public_subnet_az
  subnet_id = aws_subnet.public-subnet.id
  vpc_security_group_ids = [aws_security_group.melania-sg.id]
 
  tags = merge(local.common_tags, { Name = "API" })
 
  user_data = file("apache.sh")
}
