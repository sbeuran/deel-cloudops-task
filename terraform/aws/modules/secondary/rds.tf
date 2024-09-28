resource "aws_db_instance" "secondary_task_db" {
  allocated_storage    = 10
  publicly_accessible = true
  db_name              = var.secondary_task_db_name
  db_subnet_group_name = aws_db_subnet_group.secondary_task_db_sg.name
  vpc_security_group_ids = [ aws_security_group.allow_http_https.id ]
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  username             = var.secondary_task_db_user
  password             = var.secondary_task_db_password
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
}

resource "aws_db_subnet_group" "secondary_task_db_sg" {
  name        = "secondary-task-db-sg"
  subnet_ids  = [ 
    aws_subnet.secondary_task_vpc_private_subnet_1.id,
    aws_subnet.secondary_task_vpc_private_subnet_2.id 
  ]
}