variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "cidr_block" {
  description = "The CIDR block for the subnet"
  type        = string
}

variable "name" {
  description = "The name of the subnet"
  type        = string
}

variable "availability_zone" {
  description = "The availability zone for the subnet"
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the subnet"
  type        = map(string)
}