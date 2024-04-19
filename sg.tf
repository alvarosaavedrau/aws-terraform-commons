resource "aws_security_group" "main" {
  name   = "my-sg-${var.name}-public"
  vpc_id = aws_vpc.dev.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.common_tags,
    {
      Name = "sg-${var.name}-bastion-public"
    }
  )
}

resource "aws_security_group" "private" {
  name        = "my-sg-${var.name}-private"
  vpc_id      = aws_vpc.dev.id
  description = "Allow SSH from bastion host"
  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.main.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.common_tags,
    {
      Name = "sg-${var.name}-private"
    }
  )
}