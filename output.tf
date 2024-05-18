output "ec2_public_ip" {
  value = aws_instance.public.public_ip
}

output "ec2_private_ip" {
  value = aws_instance.private.private_ip
}

output "rds_reader_endpoint" {
  value = aws_rds_cluster.postgresql.reader_endpoint
}

output "rds_writer_endpoint" {
  value = aws_rds_cluster.postgresql.endpoint
}