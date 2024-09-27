output "primary_ec2_public_ip" {
  value = aws_instance.ec2_instance.public_ip
}

output "primary_task_ssh_private_key" {
  value     = tls_private_key.primary_task_private_key.private_key_pem
  sensitive = true
}