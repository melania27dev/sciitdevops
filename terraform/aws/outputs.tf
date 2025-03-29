output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.vpc.id
}

output "public_subnet_id" {
  description = "The ID of the public subnet"
  value       = aws_subnet.public-subnet.id
}

output "private_subnet_id" {
  description = "The ID of the private subnet"
  value       = aws_subnet.private-subnet.id
}

output "security_group_id" {
  description = "The ID of the security group"
  value       = aws_security_group.sg.id
}

output "k3s_vm_public_ip" {
  description = "EC2 K3s IP"
  value = aws_instance.k3s.public_ip
}