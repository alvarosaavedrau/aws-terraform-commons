output "ec2_public_ip" {
  value = aws_instance.public.public_ip
}

output "ec2_private_ip" {
  value = aws_instance.private.private_ip
}

output "rds_cluster_writer_endpoint" {
  value = aws_rds_cluster.rds_cluster.endpoint
}
output "rds_cluster_reader_endpoint" {
  value = aws_rds_cluster.rds_cluster.reader_endpoint
}

output "rds_cluster_database_name" {
  value = aws_rds_cluster.rds_cluster.database_name
}

output "aws_rds_cluster_instance" {
  value = aws_rds_cluster_instance.rds_instance.endpoint
}

output "aws_rds_cluster_username" {
  value = aws_rds_cluster.rds_cluster.master_username
}