

resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
  tags       = merge(local.common_tags, { Name = var.vpc_name })
}


resource "aws_internet_gateway" "net-igw" {
  vpc_id = aws_vpc.vpc.id
  tags   = merge(local.common_tags, { Name = "net-igw" })
}

resource "aws_instance" "k3s" {
  ami                    = data.aws_ami.ubuntu.id # Ubuntu AMI
  instance_type          = "t3a.medium"
  availability_zone      = var.public_subnet_az
  subnet_id              = aws_subnet.public-subnet.id
  vpc_security_group_ids = [aws_security_group.sg.id]
  key_name               = data.aws_key_pair.public_key.key_name
  
  root_block_device {
    volume_size = 20 # Set 20GB for root volume
    volume_type = "gp3"
  }
  
    tags = merge(local.common_tags, { Name = "K3s-VM" })

  #user_data = file("python_web_server.sh")
  # Use the remote-exec provisioner to run the setup script
  # provisioner "file" {
  #   source      = "python_web_server.sh"
  #   destination = "/home/ec2-user/python_web_server.sh"

  #   connection {
  #     type = "ssh"
  #     user = "ec2-user"
  #     #private_key = tls_private_key.private_key.private_key_openssh # Path to your private key
  #     host = self.public_ip
  #   }

  #}
  # provisioner "local-exec" {
  #   command = "sleep 90 && ansible_host_key_checking=false ansible-playbook -i ${self.public_ip}, -u ubuntu --private-key=./scripts/devaws.pem ./scripts/install_k3s.yml -vv"
  # }

provisioner "local-exec" {
  command = <<EOT
    sleep 90
#    chmod 400 /home/runner/work/melania27dev/melania27dev/terraform/aws/scripts/devaws.pem
    chmod 400 /home/runner/work/sciitdevops/sciitdevops/terraform/aws/scripts/devaws.pem
    ANSIBLE_HOST_KEY_CHECKING=false ansible-playbook -i ${self.public_ip}, -u ubuntu --private-key=./scripts/devaws.pem ./scripts/install_k3s.yml -vv
  EOT
}

  # provisioner "remote-exec" {
  #   inline = [
  #     "sudo chmod +x /home/ec2-user/python_web_server.sh",
  #     "/home/ec2-user/python_web_server.sh"
  #   ]

  #   connection {
  #     type = "ssh"
  #     user = "ec2-user"
  #     # private_key = tls_private_key.private_key.private_key_openssh # Path to your private key
  #     host = self.public_ip
  #   }
 # }
}


# resource "aws_instance" "web" {
#   ami                    = data.aws_ami.ubuntu.id # Ubuntu AMI
#   instance_type          = "t2.micro"
#   availability_zone      = var.public_subnet_az
#   subnet_id              = aws_subnet.public-subnet.id
#   vpc_security_group_ids = [aws_security_group.sg.id]
#   key_name               = data.aws_key_pair.public_key.key_name
  
  
  
#     tags = merge(local.common_tags, { Name = "Web-VM" })

#   #user_data = file("python_web_server.sh")
#   # Use the remote-exec provisioner to run the setup script
#   # provisioner "file" {
#   #   source      = "python_web_server.sh"
#   #   destination = "/home/ec2-user/python_web_server.sh"

#   #}
#   # provisioner "local-exec" {
#   #   command = "sleep 90 && ansible_host_key_checking=false ansible-playbook -i ${self.public_ip}, -u ubuntu --private-key=./scripts/devaws.pem ./scripts/install_k3s.yml -vv"
#   # }

# provisioner "local-exec" {
#   command = <<EOT
#     sleep 90
#     #chmod 400 /home/runner/work/melania27dev/melania27dev/terraform/aws/scripts/devaws.pem
#     #ANSIBLE_HOST_KEY_CHECKING=false ansible-playbook -i ${self.public_ip}, -u ubuntu --private-key=./scripts/devaws.pem ./scripts/install_k3s.yml -vv
#   EOT
# }
  
# }