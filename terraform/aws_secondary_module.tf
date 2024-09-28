module "aws_secondary_module" {
  source = "./aws/modules/secondary"
  
  ec2_instance_type = var.ec2_instance_type

  secondary_task_db_name = var.secondary_task_db_name
  secondary_task_db_user = var.secondary_task_db_user
  secondary_task_db_password = var.secondary_task_db_password
  secondary_task_vpc_cidr = var.secondary_task_vpc_cidr
}