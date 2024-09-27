resource "tls_private_key" "secondary_task_private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "secondary_task_keypair" {
  key_name   = "secondary_task_keypair"
  public_key = tls_private_key.secondary_task_private_key.public_key_openssh
}