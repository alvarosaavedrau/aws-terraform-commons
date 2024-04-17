resource "aws_key_pair" "personal" {
  key_name   = "keypair-sysops"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_instance" "public" {
  instance_type = "t2.micro"
  ami           = "ami-0c2b8ca1dad447f8a"
  subnet_id     = aws_subnet.publicA.id

  key_name = aws_key_pair.personal.key_name

  vpc_security_group_ids = [aws_security_group.main.id]

  tags = {
    "Name" = "ec2-sysops-bastion-public-subnetA"
  }
}

resource "aws_instance" "private" {
  instance_type = "t2.micro"
  ami           = "ami-0c2b8ca1dad447f8a"
  subnet_id     = aws_subnet.privateA.id

  vpc_security_group_ids = [aws_security_group.main.id]

  tags = {
    "Name" = "ec2-sysops-private-subnetA"
  }
}