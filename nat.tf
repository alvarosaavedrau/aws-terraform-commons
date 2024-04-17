resource "aws_eip" "publicA" {

  tags = {
    Name = "eip-${var.name}-publicA"
  }

}

resource "aws_eip" "publicB" {

  tags = {
    Name = "eip-${var.name}-publicB"
  }

}

resource "aws_nat_gateway" "publicA" {
  subnet_id = aws_subnet.publicA.id
  allocation_id = aws_eip.publicA.id
  connectivity_type = "public"

  tags = {
    Name = "nat-gateway-${var.name}-publicA"
  }

}

resource "aws_nat_gateway" "publicB" {
  subnet_id = aws_subnet.publicB.id
  allocation_id = aws_eip.publicB.id
  connectivity_type = "public"

  tags = {
    Name = "nat-gateway-${var.name}-publicB"
  }

}