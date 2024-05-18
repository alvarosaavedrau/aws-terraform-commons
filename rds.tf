resource "aws_db_subnet_group" "rds" {
  subnet_ids = [aws_subnet.privateA.id, aws_subnet.privateB.id]

  depends_on = [aws_subnet.privateA, aws_subnet.privateB]
}

resource "aws_rds_cluster" "postgresql" {
  cluster_identifier          = var.rds_cluster_name
  database_name               = var.rds_database_name
  engine                      = "aurora-postgresql"
  engine_version              = var.rds_postgre_version
  storage_encrypted           = var.rds_storage_encrypted
  master_username             = var.rds_username
  manage_master_user_password = true
  skip_final_snapshot         = var.rds_skip_final_snapshot
  deletion_protection         = var.rds_deletion_protection
  db_subnet_group_name        = aws_db_subnet_group.rds.id
  vpc_security_group_ids      = [aws_security_group.private.id]
  port                        = var.rds_port
  backup_retention_period     = var.rds_backup_retention_period
  apply_immediately           = true

  depends_on = [aws_db_subnet_group.rds, aws_security_group.private]
}

resource "aws_rds_cluster_instance" "postgresql_instance" {
  identifier                   = var.rds_instance_name
  cluster_identifier           = aws_rds_cluster.postgresql.id
  instance_class               = var.rds_instance_type
  engine                       = aws_rds_cluster.postgresql.engine
  engine_version               = aws_rds_cluster.postgresql.engine_version
  performance_insights_enabled = var.rds_instance_performance_insights
  monitoring_interval          = var.rds_instance_monitoring_interval
  auto_minor_version_upgrade   = var.rds_instance_minor_version

  depends_on = [aws_rds_cluster.postgresql]
}