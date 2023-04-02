resource "aws_rds_cluster" "default" {
  deletion_protection = false
  cluster_identifier = var.rds_cluster_prefix
  engine = var.db_engine
  engine_version = var.db_engine_version
  availability_zones = var.db_azs
  database_name = var.db_name
  master_username = var.db_master_username
  master_password = var.db_master_password
  backup_retention_period = var.backup_retention_period
  preferred_backup_window = var.preferred_backup_window
  db_subnet_group_name = aws_db_subnet_group.default.name
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.default.name
  vpc_security_group_ids = [aws_security_group.default_aurora_mysql.id]
  skip_final_snapshot = true
  storage_encrypted = true
#  enabled_cloudwatch_logs_exports = ["audit", "error", "slowquery"]

  tags = {
    "Name"  = "${var.rds_cluster_prefix}-rds-cluster"
    "Env"   = var.env
  }

  lifecycle {
    ignore_changes = [
      availability_zones
    ]
  }
}

resource "aws_rds_cluster_instance" "instance-1" {
  apply_immediately  = true
  cluster_identifier = aws_rds_cluster.default.id
  identifier         = "${var.rds_cluster_prefix}-aurora-mysql-instance-1"
  instance_class     = var.db_instance_class
  engine             = aws_rds_cluster.default.engine
  engine_version     = aws_rds_cluster.default.engine_version
  db_subnet_group_name = aws_db_subnet_group.default.name
  tags = {
    "Name"  = "${var.rds_cluster_prefix}-aurora-mysql-instance-1"
  }
}

resource "aws_rds_cluster_instance" "instance-2" {
  apply_immediately  = true
  cluster_identifier = aws_rds_cluster.default.id
  identifier         = "${var.rds_cluster_prefix}-aurora-mysql-instance-2"
  instance_class     = var.db_instance_class
  engine             = aws_rds_cluster.default.engine
  engine_version     = aws_rds_cluster.default.engine_version
  db_subnet_group_name = aws_db_subnet_group.default.name
  tags = {
    "Name"  = "${var.rds_cluster_prefix}-aurora-mysql-instance-2"
  }
}

resource "aws_db_subnet_group" "default" {
  name       = "${var.rds_cluster_prefix}-subnet-group"
  subnet_ids = var.db_subnets

  tags = {
    "Name" = "${var.rds_cluster_prefix}-subnet-group"
  }
}

resource "aws_security_group" "default_aurora_mysql" {
  name_prefix = "${var.rds_cluster_prefix}-aurora-mysql-sg"
  vpc_id      = var.vpc_id

  ingress {
    from_port = 3306
    protocol  = "tcp"
    to_port   = 3306

    cidr_blocks = var.inbound_cidr_blocks
  }
}

resource "aws_rds_cluster_parameter_group" "default" {
  name   = "${var.rds_cluster_prefix}-aurora-mysql-pg"
  family = var.mysql_cluster_parameter_group_family

  parameter {
    apply_method = "immediate"
    name  = "max_connections"
    value = var.max_connections
  }

  parameter {
    apply_method = "immediate"
    name  = "wait_timeout"
    value = var.wait_timeout
  }

  parameter {
    apply_method = "immediate"
    name  = "aurora_read_replica_read_committed"
    value = "ON"
  }

  parameter {
    apply_method = "immediate"
    name  = "transaction_isolation"
    value = var.transaction_isolation
  }

  parameter {
    apply_method = "immediate"
    name  = "sql_mode"
    value = "ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION"
  }

  parameter {
    name  = "character_set_server"
    value = var.char_set
  }

  parameter {
    name  = "character_set_client"
    value = var.char_set
  }
}