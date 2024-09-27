output "primary_ec2_public_ip" {
  value = module.ec2.primary_ec2_public_ip
}

output "primary_task_ssh_private_key" {
  value     = module.ec2.primary_task_ssh_private_key
  sensitive = true
}