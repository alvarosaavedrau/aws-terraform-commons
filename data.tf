data "aws_ami" "amzn-linux-2023-ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}

data "http" "myip" {
  url = "https://ipv4.icanhazip.com"
}

data "aws_iam_policy" "AmazonRDSEnhancedMonitoringRole" {
  name = "AmazonRDSEnhancedMonitoringRole"
}