module "network" {
  source     = "../modules/aws/network"
  cidr_block = "192.168.0.0/16"
  name       = "pomogether-vpc"

  subnets = [
    {
      name       = "pomogether-subnet-1a"
      cidr_block = "192.168.0.0/24"
      availability_zone = "us-east-1a"
    },
    {
      name       = "pomogether-subnet-1b"
      cidr_block = "192.168.1.0/24"
      availability_zone = "us-east-1b"
    },
  ]

  tags = local.tags
}

module "postgres" {
  source = "../modules/aws/database/postgres"

  cluster_identifier = "pomogether-cluster"
  engine             = "aurora-postgresql"
  engine_version     = "15.4"
  database_name      = "pomogether_db"
  master_username    = "postgres"
  master_password    = "must_be_eight_characters"
  backup_retention_period = 1
  preferred_backup_window = "00:00-05:00"
  skip_final_snapshot = true
  final_snapshot_identifier = "pomogether-final-snapshot"
  vpc_security_group_ids = null
  availability_zones = [for subnet in module.network.subnet : subnet.availability_zone]
  subnet_ids = [for subnet in module.network.subnet : subnet.id]

  instance_count = 1
  instance_class = "db.t4g.medium"
  apply_immediately = true
  
  tags = local.tags
}