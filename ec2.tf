resource "aws_key_pair" "personal" {
  key_name   = "keypair-${var.name}"
  public_key = file(var.public_key_path)
}

resource "aws_instance" "public" {
  instance_type = var.instance_type
  ami           = "ami-0c2b8ca1dad447f8a"
  subnet_id     = aws_subnet.publicA.id

  key_name = aws_key_pair.personal.key_name

  vpc_security_group_ids = [aws_security_group.main.id]

  tags = {
    "Name" = "ec2-${var.name}-bastion-public-subnetA"
  }
}

resource "aws_instance" "private" {
  instance_type = var.instance_type
  ami           = "ami-0c2b8ca1dad447f8a"
  subnet_id     = aws_subnet.privateA.id

  vpc_security_group_ids = [aws_security_group.main.id]

  tags = {
    "Name" = "ec2-${var.name}-private-subnetA"
  }
}