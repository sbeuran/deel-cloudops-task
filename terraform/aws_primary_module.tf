module "aws_primary_module" {
  source = "./aws/modules/primary"
  
  ec2_instance_type = var.ec2_instance_type
}