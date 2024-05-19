resource "aws_db_subnet_group" "rds" {
  name       = "rds-subnet-group-${var.name}-private"
  subnet_ids = [aws_subnet.privateA.id, aws_subnet.privateB.id]

  tags = merge(
    var.common_tags,
    {
      Name = "rds-subnet-group-${var.name}-private"
    }
  )

  depends_on = [aws_subnet.privateA, aws_subnet.privateB]
}

resource "aws_rds_cluster" "rds_cluster" {
  cluster_identifier           = "${var.rds_cluster_name}-${var.name}"
  database_name                = var.rds_database_name
  engine                       = var.rds_cluster_engine
  engine_version               = var.rds_cluster_version
  storage_encrypted            = var.rds_storage_encrypted
  master_username              = var.rds_username
  manage_master_user_password  = true
  skip_final_snapshot          = var.rds_skip_final_snapshot
  deletion_protection          = var.rds_deletion_protection
  db_subnet_group_name         = aws_db_subnet_group.rds.id
  vpc_security_group_ids       = [aws_security_group.private.id]
  port                         = var.rds_port
  backup_retention_period      = var.rds_backup_retention_period
  apply_immediately            = true
  preferred_maintenance_window = var.rds_cluster_maintenance_window

  tags = merge(
    var.common_tags,
    {
      Name = "${var.rds_cluster_name}-${var.name}"
    }
  )

  depends_on = [aws_db_subnet_group.rds, aws_security_group.private]
}

resource "aws_rds_cluster_instance" "rds_instance" {
  identifier                            = "${var.rds_instance_name}-writer-${var.name}"
  cluster_identifier                    = aws_rds_cluster.rds_cluster.id
  instance_class                        = var.rds_instance_type
  engine                                = aws_rds_cluster.rds_cluster.engine
  engine_version                        = aws_rds_cluster.rds_cluster.engine_version
  performance_insights_enabled          = var.rds_instance_performance_insights
  performance_insights_retention_period = var.rds_instance_insights_retention_period
  monitoring_interval                   = var.rds_instance_monitoring_interval
  monitoring_role_arn                   = aws_iam_role.rds.arn
  auto_minor_version_upgrade            = var.rds_instance_minor_version

  tags = merge(
    var.common_tags,
    {
      Name = "${var.rds_instance_name}-writer-${var.name}"
    }
  )

  depends_on = [aws_rds_cluster.rds_cluster, aws_iam_role.rds]
}

resource "aws_rds_cluster_instance" "rds_replica_reader" {
  identifier                            = "${var.rds_instance_name}-reader-${var.name}"
  cluster_identifier                    = aws_rds_cluster.rds_cluster.id
  instance_class                        = var.rds_instance_type
  engine                                = aws_rds_cluster.rds_cluster.engine
  engine_version                        = aws_rds_cluster.rds_cluster.engine_version
  performance_insights_enabled          = var.rds_instance_performance_insights
  performance_insights_retention_period = var.rds_instance_insights_retention_period
  monitoring_interval                   = var.rds_instance_monitoring_interval
  monitoring_role_arn                   = aws_iam_role.rds.arn
  auto_minor_version_upgrade            = var.rds_instance_minor_version

  tags = merge(
    var.common_tags,
    {
      Name = "${var.rds_instance_name}-reader-${var.name}"
    }
  )

  depends_on = [aws_rds_cluster.rds_cluster, aws_iam_role.rds]
}

resource "aws_iam_role" "rds" {
  name = "rds-role-${var.name}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "monitoring.rds.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "rds_attach" {
  role       = aws_iam_role.rds.name
  policy_arn = data.aws_iam_policy.AmazonRDSEnhancedMonitoringRole.arn

  depends_on = [aws_iam_role.rds, data.aws_iam_policy.AmazonRDSEnhancedMonitoringRole]
}