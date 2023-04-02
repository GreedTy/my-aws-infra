variable "env" {
  type = string
}

variable "rds_cluster_prefix" {
  type = string
}

variable "db_subnets" {
  type = list(string)
}

variable "db_azs" {
  type = list(string)
}

variable "db_master_username" {
  type = string
}

variable "db_master_password" {
  type = string
}

variable "db_name" {
  type = string
}

variable "db_engine" {
  type = string
}

variable "db_engine_version" {
  type = string
}

variable "backup_retention_period" {
  type = string
}

variable "preferred_backup_window" {
  type = string
}

variable "db_instance_class" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "inbound_cidr_blocks" {
  type = list(string)
}

variable "mysql_cluster_parameter_group_family" {
  type = string
}

variable "max_connections" {
  type = string
}

variable "transaction_isolation" {
  type = string
}

variable "wait_timeout" {
  type = string
}

variable "aurora_read_replica_read_committed" {
  type = string
}

variable "char_set" {
  type = string
}