locals {
  name = "pomogether"
  region = "us-east-1"
  environment = "dev"
  tags = {
    Name = "${local.name}-${local.environment}"
    Environment = local.environment
  }
}