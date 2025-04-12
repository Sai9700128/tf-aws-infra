resource "aws_security_group" "csye6225_db_security_group" {
  name        = "db-security-group"
  description = "Database security group for MySQL/MariaDB/PostgreSQL access"
  vpc_id      = aws_vpc.tf-aws-vpc.id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    cidr_blocks     = []
    security_groups = [aws_security_group.tf-aws-vpc-ec2_sg.id] # Application security group
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_parameter_group" "csye6225_db_param_group" {
  name        = "csye6225-db-parameter-group"
  family      = "mysql8.0"
  description = "Custom parameter group for MySQL"

  parameter {
    name  = "max_connections"
    value = "200"
  }

}
resource "aws_db_subnet_group" "csye6225_db_subnet_group" {
  name        = "csye6225-db-subnet-group"
  description = "Database subnet group for CSYE6225"
  subnet_ids  = aws_subnet.tf-aws-vpc_private_subnet[*].id

  tags = {
    Name = "CSYE6225 DB Subnet Group"
  }
}

resource "aws_db_instance" "csye6225_db_instance" {
  identifier        = var.db_identifier
  engine            = var.db_engine
  engine_version    = var.db_engine_version
  instance_class    = var.instance_class
  allocated_storage = var.allocated_storage
  db_name           = var.db_name
  username          = var.db_username
  password          = random_password.db_password.result
  # password               = var.db_password
  publicly_accessible    = var.publicly_accessible
  multi_az               = var.multi_az
  db_subnet_group_name   = aws_db_subnet_group.csye6225_db_subnet_group.name
  vpc_security_group_ids = [aws_security_group.csye6225_db_security_group.id]
  parameter_group_name   = var.parameter_group_name
  skip_final_snapshot    = true
  # This is where we assign the KMS key for RDS
  storage_encrypted = true
  kms_key_id        = aws_kms_key.rds_key.arn

  tags = {
    Name = "CSYE6225 RDS Instance"
  }
}
