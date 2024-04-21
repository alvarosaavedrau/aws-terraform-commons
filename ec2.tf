resource "aws_key_pair" "personal" {
  key_name   = "keypair-${var.name}"
  public_key = file(var.public_key_path)

  tags = merge(
    var.common_tags,
    {
      "Name" = "keypair-${var.name}",
    }
  )
}

resource "aws_instance" "public" {
  instance_type = var.instance_type
  ami           = data.aws_ami.amzn-linux-2023-ami.id
  subnet_id     = aws_subnet.publicA.id

  key_name = aws_key_pair.personal.key_name

  vpc_security_group_ids = [aws_security_group.main.id]

  user_data = file("init.sh")

  tags = merge(
    var.common_tags,
    {
      "Name" = "ec2-${var.name}-bastion-public-subnetA",
    }
  )
}

resource "aws_instance" "private" {
  instance_type = var.instance_type
  ami           = data.aws_ami.amzn-linux-2023-ami.id
  subnet_id     = aws_subnet.privateA.id

  key_name = aws_key_pair.personal.key_name // should be another key pair, best practices...

  vpc_security_group_ids = [aws_security_group.private.id]

  tags = merge(
    var.common_tags,
    {
      "Name" = "ec2-${var.name}-private-subnetA",
    }
  )
}