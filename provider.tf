provider "aws" {
  region                = var.region
  access_key            = var.access_key
  secret_key            = var.secret_key
  forbidden_account_ids = var.personal_account_id
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.50.0"
    }
  }
  required_version = ">= 1.8.2"
}