resource "aws_vpc" "main" {
  cidr_block = var.cidr_block

  tags = merge(var.tags, {
    Name = var.name
  })
}

module "subnet" {
  for_each = {
    for idx, subnet in var.subnets:
    idx => subnet
  }

  source   = "./subnet"
  vpc_id   = aws_vpc.main.id
  name     = each.value.name
  cidr_block = each.value.cidr_block
  availability_zone = each.value.availability_zone
  
  tags = merge(var.tags, {
    Name = each.value.name
  })
}
