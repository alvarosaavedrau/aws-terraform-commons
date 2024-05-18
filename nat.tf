resource "aws_eip" "publicA" {

  tags = merge(
    var.common_tags,
    {
      Name = "eip-${var.name}-publicA"
    }
  )
}

resource "aws_nat_gateway" "publicA" {
  subnet_id         = aws_subnet.publicA.id
  allocation_id     = aws_eip.publicA.id
  connectivity_type = "public"

  tags = merge(
    var.common_tags,
    {
      Name = "nat-gateway-${var.name}-publicA"
    }
  )

  depends_on = [ aws_subnet.publicA, aws_eip.publicA ]
}