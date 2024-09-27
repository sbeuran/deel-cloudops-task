resource "tls_private_key" "primary_task_private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "primary_task_keypair" {
  key_name   = "primary_task_keypair"
  public_key = tls_private_key.primary_task_private_key.public_key_openssh
}