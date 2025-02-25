

# Variable for the AWS CLI profile
variable "profile" {
  description = "The AWS CLI profile to use"
  type        = string
  default     = "dev"
}

# Variable for the AWS regi

# Variable for the VPC CIDR block
variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16" # Default CIDR block
}

# public subnet

variable "cidr_public_subnet" {
  type        = list(string)
  description = "Public Subnet CIDR values"
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"] # 3 different availability_zones
}

# private subnet

variable "cidr_private_subnet" {
  type        = list(string)
  description = " Private Subnet CIDR values"
  default     = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"] # 3 different availability_zones
}


#availability_zones


variable "us-availability_zones" {
  type        = list(string)
  description = "Availability_zones"
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}


# CIDR Block for Route Table

variable "cidr_block" {
  type        = string
  description = "Route Table CIDR block"
  default     = "0.0.0.0/0"
}