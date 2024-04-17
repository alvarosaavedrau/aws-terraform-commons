output "ec2_public_ip" {
    value = aws_instance.public.public_ip
}

output "ec2_private_ip" {
    value = aws_instance.private.private_ip
}