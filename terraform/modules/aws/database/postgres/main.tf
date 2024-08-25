resource "aws_db_subnet_group" "main" {
  name       = "${var.cluster_identifier}-subnet-group"
  subnet_ids = var.subnet_ids

  tags       = merge(var.tags, {
    Name = "${var.cluster_identifier}-subnet-group"
    ClusterIdentifier = var.cluster_identifier
  })
}

resource "aws_rds_cluster" "main" {
  cluster_identifier        = var.cluster_identifier
  engine                    = var.engine
  engine_version            = var.engine_version
  availability_zones        = var.availability_zones
  database_name             = var.database_name
  master_username           = var.master_username
  master_password           = var.master_password
  backup_retention_period   = var.backup_retention_period
  preferred_backup_window   = var.preferred_backup_window
  skip_final_snapshot       = var.skip_final_snapshot
  final_snapshot_identifier = var.final_snapshot_identifier
  vpc_security_group_ids    = var.vpc_security_group_ids
  db_subnet_group_name      = aws_db_subnet_group.main.name

  tags                      = merge(var.tags, {
    Name = var.cluster_identifier
  })

  dynamic "serverlessv2_scaling_configuration" {
    for_each = var.serverlessv2_scaling_configuration != null ? [var.serverlessv2_scaling_configuration] : []
    content {
      max_capacity = serverlessv2_scaling_configuration.value.max_capacity
      min_capacity = serverlessv2_scaling_configuration.value.min_capacity
    }
  }
}

resource "aws_rds_cluster_instance" "main" {
  count              = var.instance_count
  cluster_identifier = aws_rds_cluster.main.id
  instance_class     = var.instance_class
  engine             = var.engine
  engine_version     = var.engine_version
  identifier         = "${var.cluster_identifier}-instance-${count.index}"
  apply_immediately  = var.apply_immediately

  tags               = merge(var.tags, {
    Name = "${var.cluster_identifier}-instance-${count.index}"
    ClusterIdentifier = var.cluster_identifier
  })
}

