# output "primary_ec2_public_ip" {
#   value = module.aws_primary_module.primary_ec2_public_ip
# }

# output "primary_task_ssh_private_key" {
#   value     = module.aws_primary_module.primary_task_ssh_private_key
#   sensitive = true
# }

output "secondary_ec2_public_ip" {
  value = module.aws_secondary_module.secondary_ec2_public_ip
}

output "secondary_task_ssh_private_key" {
  value     = module.aws_secondary_module.secondary_task_ssh_private_key
  sensitive = true
}