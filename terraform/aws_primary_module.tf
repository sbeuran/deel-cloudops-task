module "ec2" {
  source = "./aws/modules/primary"
  
  ec2_instance_ami_id = var.ec2_instance_ami_id
  ec2_instance_type = var.ec2_instance_type
}