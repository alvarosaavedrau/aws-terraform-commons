provider "aws" {
  region                = var.region
  access_key            = var.access_key
  secret_key            = var.secret_key
  forbidden_account_ids = var.personal_account_id
}
