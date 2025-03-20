

# Variable for the AWS CLI profile
variable "profile" {
  description = "The AWS CLI profile to use"
  type        = string
}

# Variable for the AWS region
variable "region" {
  description = "The AWS region to create resources in"
  type        = string
}

# Variable for the VPC CIDR block
variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC"
}

# public subnet

variable "cidr_public_subnet" {
  type        = list(string)
  description = "Public Subnet CIDR values"
}

# private subnet

variable "cidr_private_subnet" {
  type        = list(string)
  description = " Private Subnet CIDR values"
}


#availability_zones


variable "us-availability_zones" {
  type        = list(string)
  description = "Availability_zones"
}


# CIDR Block for Route Table

variable "cidr_block" {
  type        = string
  description = "Route Table CIDR block"
}

# Variable for the public key path
variable "public_key_path" {
  description = "The path to the public key file"
  type        = string
}


variable "db_identifier" {
  description = "The identifier for the RDS instance"
  type        = string
  default     = "csye6225"
}

variable "db_engine" {
  description = "The RDS engine"
  type        = string
}

variable "db_engine_version" {
  description = "The version of the RDS engine"
  type        = string
}

variable "instance_class" {
  description = "The instance class for the RDS instance"
  type        = string
}

variable "allocated_storage" {
  description = "The allocated storage for the RDS instance"
  type        = number
}

variable "db_name" {
  description = "The name of the database"
  type        = string
}

variable "db_username" {
  description = "The username for the RDS instance"
  type        = string
}

variable "db_password" {
  description = "The password for the RDS instance"
  type        = string
  sensitive   = true
}

variable "publicly_accessible" {
  description = "Whether the RDS instance is publicly accessible"
  type        = bool
}

variable "multi_az" {
  description = "Whether the RDS instance is multi-AZ"
  type        = bool
}

variable "subnet_group_name" {
  description = "The subnet group for the RDS instance"
  type        = string
  default     = "your_subnet_group_name"
}

variable "parameter_group_name" {
  description = "The name of the DB parameter group"
  type        = string
  default     = "csye6225-db-parameter-group"
}


variable "AWS_Region" {
  type = string
}
variable "app_port" {
  description = "Application port"
  type        = number
}


variable "ami_id" {
  type = string
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "key_name" {
  type = string
}
