module "aws_secondary_module" {
  source = "./aws/modules/secondary"
  
  ec2_instance_type = var.ec2_instance_type
}