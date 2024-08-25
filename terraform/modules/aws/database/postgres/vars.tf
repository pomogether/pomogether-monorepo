variable "cluster_identifier" {
  description = "The cluster identifier"
  type = string
}

variable "engine" {
  description = "The database engine to use"
  type = string
}

variable "engine_version" {
  description = "The database engine version"
  type = string
}

variable "availability_zones" {
  description = "The availability zones"
  type = list(string)
}

variable "database_name" {
  description = "The database name"
  type = string
}

variable "master_username" {
  description = "The master username"
  type = string
}

variable "master_password" {
  description = "The master password"
  type = string
}

variable "backup_retention_period" {
  description = "The backup retention period"
  type = number
}

variable "preferred_backup_window" {
  description = "The preferred backup window"
  type = string
}

variable "skip_final_snapshot" {
  description = "Skip the final snapshot"
  type = bool
}

variable "final_snapshot_identifier" {
  description = "The final snapshot identifier"
  type = string
}

variable "vpc_security_group_ids" {
  description = "The VPC security group IDs"
  type = list(string)
}

variable "subnet_ids" {
  description = "The subnet IDs"
  type = list(string)
}

variable "tags" {
  description = "The tags"
  type = map(string)
}

variable "instance_count" {
  description = "The instance count"
  type = number
}

variable "instance_class" {
  description = "The instance class"
  type = string
}

variable "apply_immediately" {
  description = "Apply immediately"
  type = bool
}

variable "serverlessv2_scaling_configuration" {
  description = "The serverlessv2 scaling configuration"
  type = object({
    max_capacity = number
    min_capacity = number
  })

  default = null
}

