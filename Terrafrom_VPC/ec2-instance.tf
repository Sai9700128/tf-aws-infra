# IAM role for the EC2 instance
resource "aws_iam_role" "ec2_role" {
  name = "EC2-S3-RDS-CloudWatch-Access"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Effect = "Allow"
        Sid    = ""
      }
    ]
  })
}

# Attach AmazonS3FullAccess (For S3 operations)
resource "aws_iam_role_policy_attachment" "s3_access" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

# Attach AmazonRDSFullAccess (For database operations)
resource "aws_iam_role_policy_attachment" "rds_access" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonRDSFullAccess"
}

# Attach CloudWatchAgentServerPolicy (For collecting logs)
resource "aws_iam_role_policy_attachment" "cloudwatch_agent_access" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

# **New Policy:** Attach CloudWatchFullAccess or Custom PutMetricData policy
resource "aws_iam_role_policy_attachment" "cloudwatch_full_access" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchFullAccess"
}

# Instance Profile to attach the IAM Role to EC2
resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "EC2-S3-RDS-CloudWatch-Access"
  role = aws_iam_role.ec2_role.name
}



# Launch Template for EC2 instances
# This template will be used by the Auto Scaling Group to launch instances
# Change from standalone to launch template

resource "aws_launch_template" "csye6225_server" {
  name          = "csye6225-server"
  image_id      = var.ami_id
  instance_type = var.instance_type

  network_interfaces {
    subnet_id                   = aws_subnet.tf-aws-vpc_public_subnet[0].id
    associate_public_ip_address = true
    security_groups             = [aws_security_group.tf-aws-vpc-ec2_sg.id]
  }
  iam_instance_profile {
    name = aws_iam_instance_profile.ec2_instance_profile.name
  }
  key_name                = var.key_name
  disable_api_termination = false

  # User data to set up environment variables and DB configuration (encoded in Base64)
  user_data = base64encode(<<-EOF
    #!/bin/bash
    echo "DB_URL=jdbc:mysql://${aws_db_instance.csye6225_db_instance.endpoint}/${var.db_name}" | sudo tee -a /etc/environment
    echo "DB_USERNAME=${var.db_username}" | sudo tee -a /etc/environment
    echo "DB_PASSWORD=${var.db_password}" | sudo tee -a /etc/environment
    echo "DB_NAME=${var.db_name}" | sudo tee -a /etc/environment
    echo "AWS_BUCKET_NAME=${aws_s3_bucket.private_bucket.id}" | sudo tee -a /etc/environment
    echo "AWS_REGION=${var.AWS_Region}" | sudo tee -a /etc/environment
    source /etc/environment
  EOF
  )

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size           = 25
      volume_type           = "gp2"
      delete_on_termination = true
    }
  }

  tags = {
    Name = "csye6225-EC2"
  }

  depends_on = [
    aws_db_instance.csye6225_db_instance,
    aws_iam_instance_profile.ec2_instance_profile
  ]
}
