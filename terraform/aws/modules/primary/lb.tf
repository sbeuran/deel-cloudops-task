resource "aws_lb" "primary_task_lb" {
  name               = "primary-task-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [ aws_security_group.allow_http_https.id ]
  subnets            = [ 
    aws_subnet.primary_task_vpc_subnet1.id,
    aws_subnet.primary_task_vpc_subnet2.id,
  ]

  enable_deletion_protection = false
}

resource "aws_alb_target_group" "primary_task_alb_tg" {
	name	= "primary-task-alb-tg"
	vpc_id	= aws_vpc.primary_task_vpc.id
	port	= "80"
	protocol	= "HTTP"
	health_check {
        path = "/"
        port = "80"
        protocol = "HTTP"
        healthy_threshold = 2
        unhealthy_threshold = 2
        interval = 5
        timeout = 4
        matcher = "200-308"
    }
}

resource "aws_alb_target_group_attachment" "primary_task_alb_tg_attachment" {
  target_group_arn = aws_alb_target_group.primary_task_alb_tg.arn
  target_id        = aws_instance.ec2_instance.id
  port             = 80
}