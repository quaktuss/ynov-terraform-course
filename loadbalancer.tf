data "aws_subnets" "vpc_subnets" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
}

resource "aws_lb" "main-lb" {
  name = "MPN-LoadBalancer"

  security_groups = [aws_security_group.lb-sg.id]
  subnets         = data.aws_subnets.vpc_subnets.ids
}

resource "aws_lb_target_group" "instance-targetgroup" {
  name     = "MPN-TargetGroup"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

# resource "aws_lb_target_group_attachment" "main-attachment" {
#   target_group_arn = aws_lb_target_group.instance-targetgroup.arn
#   target_id        = aws_lb.main-lb.arn
#   port             = 80
# }

resource "aws_autoscaling_attachment" "example" {
  autoscaling_group_name = aws_autoscaling_group.main-asg.name
  lb_target_group_arn    = aws_lb_target_group.instance-targetgroup.arn
}

resource "aws_lb_listener" "name" {
  load_balancer_arn = aws_lb.main-lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.instance-targetgroup.arn
    type             = "forward"
  }
}
