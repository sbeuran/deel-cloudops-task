output "secondary_ec2_public_ip" {
  value = aws_instance.ec2_instance.public_ip
}

output "secondary_task_ssh_private_key" {
  value     = tls_private_key.secondary_task_private_key.private_key_pem
  sensitive = true
}