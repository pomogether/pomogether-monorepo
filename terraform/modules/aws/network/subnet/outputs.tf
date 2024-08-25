output "id" {
  description = "The ID of the subnet"
  value = aws_subnet.main.id
}

output "cidr_block" {
  description = "The CIDR block of the subnet"
  value = aws_subnet.main.cidr_block
}

output "availability_zone" {
  description = "The availability zone of the subnet"
  value = aws_subnet.main.availability_zone
}

output "vpc_id" {
  description = "The ID of the VPC"
  value = aws_subnet.main.vpc_id
}

output "arn" {
  description = "The ARN of the subnet"
  value = aws_subnet.main.arn
}

output "ipv6_cidr_block" {
  description = "The IPv6 CIDR block of the subnet"
  value = aws_subnet.main.ipv6_cidr_block
}

output "owner_id" {
  description = "The ID of the AWS account that owns the subnet"
  value = aws_subnet.main.owner_id
}

output "name" {
  description = "The name of the subnet"
  value = var.name
}