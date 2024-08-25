output "subnet" {
  description = "The subnet"
  value = {
    for idx, subnet in module.subnet:
    subnet.name => {
      id               = subnet.id
      cidr_block       = subnet.cidr_block
      availability_zone = subnet.availability_zone
      vpc_id           = subnet.vpc_id
      arn              = subnet.arn
      ipv6_cidr_block  = subnet.ipv6_cidr_block
      owner_id         = subnet.owner_id
    }
  } 
}