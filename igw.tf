resource "aws_internet_gateway" "dev" {
  vpc_id = aws_vpc.dev.id

  tags = merge(
    var.custom_tags,
    {
      "Name" = "igw-${var.name}",
    }
  )
}