output "ec2_public_ip" {
    value = aws_instance.dev.public_ip
  
}
output "ec2_private_ip" {
    value = aws_instance.dev.private_ip
  
}