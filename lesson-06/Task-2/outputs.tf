# Print the instance public IP
# Output the public IPs of the instances
output "instance_public_ips" {
  value = [
    for instance in data.aws_instance.example_instance_details :
    instance.public_ip
  ]
}

