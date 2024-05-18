resource "aws_security_group" "public" {
  name   = "my-sg-${var.name}-public"
  vpc_id = aws_vpc.dev.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${chomp(data.http.myip.response_body)}/32"]
    description = "Allow SSH only from own public ip"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow TCP 80 from everywhere"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow outbound traffic from instance to everywhere"
  }

  tags = merge(
    var.common_tags,
    {
      Name = "my-sg-${var.name}-public"
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
    security_groups = [aws_security_group.public.id]
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
      Name = "my-sg-${var.name}-private"
    }
  )
}