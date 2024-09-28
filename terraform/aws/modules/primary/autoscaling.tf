resource "aws_launch_template" "primary_aws_launch_template" {
  name_prefix   = "primary"
  image_id      = data.aws_ami.amazon_linux_2.id
  instance_type = var.ec2_instance_type
}

resource "aws_autoscaling_group" "primary_aws_autoscaling_group" {
  availability_zones = [ 
    data.aws_availability_zones.available.names[0],
    data.aws_availability_zones.available.names[1]
  ]
  desired_capacity   = 1
  max_size           = 2
  min_size           = 1

  launch_template {
    id      = aws_launch_template.primary_aws_launch_template.id
    version = "$Latest"
  }
}

resource "aws_autoscaling_attachment" "primary_aws_autoscaling_attachment" {
  autoscaling_group_name = aws_autoscaling_group.primary_aws_autoscaling_group.name
  lb_target_group_arn = aws_alb_target_group.primary_task_alb_tg.arn
}