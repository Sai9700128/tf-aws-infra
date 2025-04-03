# Autoscaling Groups

resource "aws_autoscaling_group" "tf-aws-vpc-asg" {
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
  name                   = "scale-up-policy"                         # Name of the scaling policy
  autoscaling_group_name = aws_autoscaling_group.tf-aws-vpc-asg.name # Reference the ASG created above                                        # Increase the capacity by 1 instance
  adjustment_type        = "ChangeInCapacity"                        # Change the capacity by 1 instance
  # cooldown                = 60                                        # Cooldown period in seconds
  metric_aggregation_type = "Average" # Average of the metric data points3

  policy_type = "StepScaling" # Type of scaling policy

  step_adjustment {
    metric_interval_lower_bound = 5.0 # CPU > 5%
    scaling_adjustment          = 1   # Add 1 instance
  }

  # target_tracking_configuration {
  #   target_value = 5
  #   predefined_metric_specification {
  #     predefined_metric_type = "ASGAverageCPUUtilization" # Metric to track
  #   }

  # }
}

# Create an Auto Scaling policies for scaling down

resource "aws_autoscaling_policy" "scale_down" {
  name                   = "sale-down-policy"                        # Name of the scaling policy
  autoscaling_group_name = aws_autoscaling_group.tf-aws-vpc-asg.name # Reference the ASG created above

  adjustment_type = "ChangeInCapacity" # Change the capacity by 1 instance
  # cooldown                = 60                 # Cooldown period in seconds
  metric_aggregation_type = "Average"     # Average of the metric data points
  policy_type             = "StepScaling" # Type of scaling policy
  # target_tracking_configuration {
  #   target_value = 3
  #   predefined_metric_specification {
  #     predefined_metric_type = "ASGAverageCPUUtilization" # Metric to track
  #   }
  # }

  step_adjustment {
    metric_interval_lower_bound = 3.0 # CPU > 5%
    scaling_adjustment          = 1   # Add 1 instance
  }
}
