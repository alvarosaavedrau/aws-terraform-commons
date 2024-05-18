variable "access_key" {
  type = string
}

variable "secret_key" {
  type = string
}

variable "region" {
  type = string
}

variable "personal_account_id" {
  type        = list(string)
  description = "List of personal account IDs to deny terraform create"
}

variable "public_key_path" {
  type        = string
  description = "Path to the public key to create the key pair"
}

variable "instance_type" {
  type        = string
  description = "Type of EC2 instance to provision"
  default     = "t2.micro"
}

variable "name" {
  type = string
}

variable "common_tags" {
  description = "Common tags to the resources"
  type        = map(string)
}

variable "rds_cluster_name" {
  type        = string
  description = "Name of the RDS cluster"
}

variable "rds_username" {
  type        = string
  description = "Username to connect to RDS"
}

variable "rds_postgre_version" {
  type        = string
  description = "Postgre version to use"
}

variable "rds_storage_encrypted" {
  type        = bool
  description = "Encrypt RDS storage"
}

variable "rds_skip_final_snapshot" {
  type        = string
  description = "Skip RDS final snapshot"
}

variable "rds_deletion_protection" {
  type        = bool
  description = "Enable RDS deletion protection"
}

variable "rds_port" {
  type        = number
  description = "RDS port"
}

variable "rds_backup_retention_period" {
  type        = number
  description = "RDS backup retention period"
}

variable "rds_instance_name" {
  type        = string
  description = ""
}

variable "rds_instance_type" {
  type        = string
  description = "RDS instance type"
}

variable "rds_instance_performance_insights" {
  type        = bool
  description = "RDS instance performance insights"
}

variable "rds_instance_monitoring_interval" {
  type        = string
  description = "RDS instance monitoring interval"
}

variable "rds_instance_minor_version" {
  type        = bool
  description = "RDS instance minor version"
}

variable "rds_database_name" {
  type = string
  description = "RDS database name"
}