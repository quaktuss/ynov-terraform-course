resource "aws_launch_template" "main-lt" {
  name        = "mpn-launchtemplate"
  description = "Mathieu PHERON launch template"

  image_id      = var.webserver_ami_id
  instance_type = var.instance_type
  key_name      = "MPN-KeyPair"

  # vpc_security_group_ids = var.instance_sg_id

  update_default_version               = true
  instance_initiated_shutdown_behavior = "stop"

  network_interfaces {
    associate_public_ip_address = false
    security_groups             = [aws_security_group.instance-sg.id]
  }
}

resource "aws_autoscaling_group" "main-asg" {
  vpc_zone_identifier = data.aws_subnets.vpc_subnets.ids
  # availability_zones  = var.authorized-asg-az
  name             = "MPN-AutoscalingGroup"
  max_size         = var.asg_capacity.max_size
  min_size         = var.asg_capacity.min_size
  desired_capacity = var.asg_capacity.desired_capacity

  target_group_arns = [aws_lb_target_group.instance-targetgroup.arn]

  launch_template {
    id      = aws_launch_template.main-lt.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "MPN-Instance"
    propagate_at_launch = true
  }
}
