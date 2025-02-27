data "aws_subnet" "tf-aws-vpc_public_subnet" {
  filter {
    name   = "tag:Name"
    values = ["Public-Subnet : tf-aws-vpc 1"]
  }
  depends_on = [
    aws_route_table_association.public_subnet_association
  ]
}

data "aws_ami" "custom_ami" {
  most_recent = true
  owners      = ["self"]
  filter {
    name   = "name"
    values = ["csye6225_health_checker_2025_02_27_07_02_34"]
  }
}

resource "aws_instance" "ec2_instance" {
  ami                         = data.aws_ami.custom_ami.id
  instance_type               = "t2.micro"
  subnet_id                   = data.aws_subnet.tf-aws-vpc_public_subnet.id
  vpc_security_group_ids      = [aws_security_group.tf-aws-vpc-ec2_sg.id]
  key_name                    = aws_key_pair.deployer.key_name
  associate_public_ip_address = true

  tags = {
    Name = "EC2-Instance_using_Custom_AMI"
  }
  disable_api_termination = false # Allows termination (Protect against accidental termination: No)

  root_block_device {
    volume_size           = 25
    volume_type           = "gp2"
    delete_on_termination = true # Ensures EBS volume is deleted with EC2 termination
  }
}

resource "aws_key_pair" "deployer" {
  key_name   = "aws_key_pair"
  public_key = file(var.public_key_path)
}