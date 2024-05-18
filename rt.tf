resource "aws_route_table" "private" {
  vpc_id = aws_vpc.dev.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.publicA.id
  }

  tags = merge(
    var.common_tags,
    {
      Name = "route-table-${var.name}-private"
    }
  )

  depends_on = [ aws_vpc.dev ]
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.dev.id

  tags = merge(
    var.common_tags,
    {
      Name = "route-table-${var.name}-public"
    }
  )

  depends_on = [ aws_vpc.dev ]
}

resource "aws_route_table_association" "privateA" {
  subnet_id      = aws_subnet.privateA.id
  route_table_id = aws_route_table.private.id

  depends_on = [ aws_subnet.privateA, aws_route_table.private ]
}

resource "aws_route_table_association" "publicA" {
  subnet_id      = aws_subnet.publicA.id
  route_table_id = aws_route_table.public.id

  depends_on = [ aws_subnet.publicA, aws_route_table.public ]
}

resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.dev.id

  depends_on = [ aws_route_table.public, aws_internet_gateway.dev ]
}