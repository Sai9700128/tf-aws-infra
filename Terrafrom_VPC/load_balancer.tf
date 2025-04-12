# Steps to create the Load Balancer:
# 1. Define Load Balancer security group
# 2. Create Load Balancer
# 3. Create Target Group
# 4. Create Listener
# 5. Mention the load balancer in autoscaling group


variable "certificate_arn" {
  description = "The ARN of the SSL certificate to use for HTTPS"
  type        = string
}



# 1. Define Load Balancer security group

# Defined in aws-security-groups file

# 2. Create Load Balancer
resource "aws_lb" "ALB" {
  internal                         = false
  load_balancer_type               = "application"
  security_groups                  = [aws_security_group.load_balancer_sg.id]
  subnets                          = [aws_subnet.tf-aws-vpc_public_subnet[0].id, aws_subnet.tf-aws-vpc_public_subnet[1].id]
  enable_deletion_protection       = false
  enable_cross_zone_load_balancing = true

  tags = {
    Name = "Application-load-balancer"
  }
}



# 3. Create Target Group

resource "aws_lb_target_group" "target_group" {
  name     = "csye6225-target-group"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = aws_vpc.tf-aws-vpc.id
  health_check {
    path                = "/healthz"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }
}



# 4. Create Listener

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.ALB.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.certificate_arn


  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}


# 5. Mention the target load balancer in autoscaling group

# Attached the target load balancer to the autoscaling group file
