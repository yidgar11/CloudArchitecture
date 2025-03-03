# Print the instance public IP
output "instance_ip" {
  value = aws_instance.example.public_ip
}

