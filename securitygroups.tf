resource "aws_security_group" "instance-sg" {
  name        = "MPN-SecurityGroup_EC2"
  description = "Allows http from alb securitygroups and nothing else"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "MPN-SecurityGroup_EC2"
  }
}


resource "aws_vpc_security_group_ingress_rule" "allows_http_from_lb" {
  security_group_id            = aws_security_group.instance-sg.id
  referenced_security_group_id = aws_security_group.lb-sg.id

  from_port   = 80
  ip_protocol = "tcp"
  to_port     = 80
}

resource "aws_security_group" "lb-sg" {
  name        = "MPN-SecurityGroup_LB"
  description = "Allows http from alb securitygroups and nothing else"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "MPN-SecurityGroup_LB"
  }
}


resource "aws_vpc_security_group_ingress_rule" "allows_http_from_myip" {
  security_group_id = aws_security_group.lb-sg.id
  cidr_ipv4         = var.my_ip

  from_port   = 80
  ip_protocol = "tcp"
  to_port     = 80
}
