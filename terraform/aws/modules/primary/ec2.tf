

resource "aws_instance" "ec2_instance" {
  ami           = data.aws_ami.amazon_linux_2.id
  instance_type = var.ec2_instance_type

  
  associate_public_ip_address = true
  vpc_security_group_ids = [ aws_security_group.allow_http_https.id ]
  subnet_id = aws_subnet.primary_task_vpc_subnet1.id

  user_data = <<-EOF
    #!/bin/bash
    set -ex
    sudo yum update -y
    sudo amazon-linux-extras install docker -y
    sudo service docker start
    sudo usermod -a -G docker ec2-user
    docker run -d --name web -p 80:80 yeasy/simple-web:latest
  EOF

  key_name = aws_key_pair.primary_task_keypair.key_name

  provisioner "remote-exec" {
    script = "scripts/wait_for_yeasy_web.sh"
    connection {
      host = self.public_ip
      user = "ec2-user"
      private_key = tls_private_key.primary_task_private_key.private_key_pem
    }
  }

  tags = {
    Name = "primary-task-ec2"
  }
}