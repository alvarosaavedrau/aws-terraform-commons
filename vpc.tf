resource "aws_vpc" "dev" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_hostnames = true

  tags = merge(
    var.common_tags,
    {
      Name = "vpc-${var.name}"
    }
  )
}

resource "aws_subnet" "publicA" {
  vpc_id                  = aws_vpc.dev.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = merge(
    var.common_tags,
    {
      Name = "subnet-${var.name}-publicA"
    }
  )

  depends_on = [aws_vpc.dev]
}

resource "aws_subnet" "publicB" {
  vpc_id                  = aws_vpc.dev.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = merge(
    var.common_tags,
    {
      Name = "subnet-${var.name}-publicB"
    }
  )

  depends_on = [aws_subnet.publicA]
}

resource "aws_subnet" "privateA" {
  vpc_id                  = aws_vpc.dev.id
  cidr_block              = "10.0.16.0/20"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = false

  tags = merge(
    var.common_tags,
    {
      Name = "subnet-${var.name}-privateA"
    }
  )

  depends_on = [aws_subnet.publicB]
}

resource "aws_subnet" "privateB" {
  vpc_id                  = aws_vpc.dev.id
  cidr_block              = "10.0.32.0/20"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = false

  tags = merge(
    var.common_tags,
    {
      Name = "subnet-${var.name}-privateB"
    }
  )

  depends_on = [aws_subnet.privateA]
}