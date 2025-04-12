# Autoscaling Groups

resource "aws_autoscaling_group" "tf-aws-vpc-asg" {
  name             = "csye6225-asg"
  desired_capacity = 1
  max_size         = 5
  min_size         = 1
  # cooldown attribute removed as it is not valid for aws_autoscaling_group
  launch_template {
    id      = aws_launch_template.csye6225_server.id
    version = "$Latest" # Uses the latest version of the launch template
  }
  depends_on = [aws_launch_template.csye6225_server] # Ensure the launch template is created before the ASG

  target_group_arns = [aws_lb_target_group.target_group.arn] # Reference the target group created above

  tag {
    key                 = "Name"
    value               = "csye6225-asg"
    propagate_at_launch = true
  }

  health_check_type         = "EC2"
  health_check_grace_period = 300
  force_delete              = true # Force delete the ASG even if there are instances in it
}


# Create an Auto Scaling policies for scaling up

# Simple Scaling Policy
# StepScaling Policy
# Target Tracking Policy

resource "aws_autoscaling_policy" "scale_up" {
  name                   = "scale-up-policy"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 60
  autoscaling_group_name = aws_autoscaling_group.tf-aws-vpc-asg.name
}

# target_tracking_configuration {
#   target_value = 5
#   predefined_metric_specification {
#     predefined_metric_type = "ASGAverageCPUUtilization" # Metric to track
#   }

# }
resource "aws_cloudwatch_metric_alarm" "cpu_high" {
  alarm_name          = "cpu-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Average"
  threshold           = 5
  alarm_description   = "Scale up if CPU > 5%"
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.tf-aws-vpc-asg.name
  }

  alarm_actions = [aws_autoscaling_policy.scale_up.arn]
}

# Create an Auto Scaling policies for scaling down

resource "aws_autoscaling_policy" "scale_down" {
  name                   = "scale-down-policy"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 60
  autoscaling_group_name = aws_autoscaling_group.tf-aws-vpc-asg.name
}

resource "aws_cloudwatch_metric_alarm" "cpu_low" {
  alarm_name          = "cpu-low"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Average"
  threshold           = 3
  alarm_description   = "Scale down if CPU < 3%"
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.tf-aws-vpc-asg.name
  }

  alarm_actions = [aws_autoscaling_policy.scale_down.arn]
}

