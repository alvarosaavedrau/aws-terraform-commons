resource "aws_internet_gateway" "dev" {
  vpc_id = aws_vpc.dev.id

  tags = merge(
    var.common_tags,
    {
      "Name" = "igw-${var.name}",
    }
  )

  depends_on = [aws_vpc.dev]
}