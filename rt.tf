resource "aws_route_table" "private" {
  vpc_id = aws_vpc.dev.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.publicA.id
  }

  tags = merge(
    var.custom_tags,
    {
      Name = "route-table-${var.name}-private"
    }
  )
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.dev.id

  tags = merge(
    var.custom_tags,
    {
      Name = "route-table-${var.name}-public"
    }
  )
}

resource "aws_route_table_association" "privateA" {
  subnet_id      = aws_subnet.privateA.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "privateB" {
  subnet_id      = aws_subnet.privateB.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "publicA" {
  subnet_id      = aws_subnet.publicA.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "publicB" {
  subnet_id      = aws_subnet.publicB.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.dev.id
}