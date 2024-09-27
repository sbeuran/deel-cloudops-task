

resource "aws_instance" "ec2_instance" {
  ami           = data.aws_ami.amazon_linux_2.id
  instance_type = var.ec2_instance_type

  
  associate_public_ip_address = true
  vpc_security_group_ids = [ aws_security_group.allow_http_https.id ]
  subnet_id = aws_subnet.primary_task_vpc_subnet.id

  user_data = <<-EOF
    #!/bin/bash
    set -ex
    sudo yum update -y
    sudo amazon-linux-extras install docker -y
    sudo service docker start
    sudo usermod -a -G docker ec2-user
    docker run -d -p 80:80 yeasy/simple-web:latest
  EOF

  tags = {
    Name = "primary-task-ec2"
  }
}