variable "name" {
  description = "The name of the VPC"
  type        = string 
}

variable "cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "subnets" {
  description = "A list of subnets to create"
  type        = list(object({
    name       = string
    cidr_block = string
    availability_zone = string
  }))
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
}