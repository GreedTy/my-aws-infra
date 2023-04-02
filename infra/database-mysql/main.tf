module "database" {
  source = "../../module/database-mysql"

  rds_cluster_prefix      = "${local.system_full_name}-micro-1"
  vpc_id                  = data.aws_vpc.vpc.id
  db_subnets              = data.aws_subnets.db_private.ids
  env                     = var.env
  db_azs                  = ["ap-northeast-2a", "ap-northeast-2c"]
  db_name                 = "microservice"
  db_master_username      = "master"
  db_master_password      = var.db_master_password
  db_engine               = "aurora-mysql"
  db_engine_version       = "8.0.mysql_aurora.3.01.0"
  mysql_cluster_parameter_group_family = "aurora-mysql8.0"
  max_connections         = "100"
  db_instance_class       = "db.t3.medium"
  char_set                = "utf8mb4"
  inbound_cidr_blocks     = [data.aws_vpc.vpc.cidr_block]
  aurora_read_replica_read_committed   = "ON"
  backup_retention_period              = "5"
  preferred_backup_window              = "07:00-09:00"
  transaction_isolation                = "READ-COMMITTED"
  wait_timeout                         = "60"
}

data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = ["test-micro"]
  }
}

data aws_subnets "private" {
  filter {
    name   = "micro-private-subnet-a"
    values = "micro-private-subnet-*"
  }
}
data "aws_subnet" "private" {
  for_each = toset(data.aws_subnets.private.ids)
  id       = each.value
}

data "aws_subnets" "db_private" {
  filter {
    name   = "tag:Name"
    values = [
      "micro-private-subnet-a",
      "micro-private-subnet-c"
    ]
  }
}
