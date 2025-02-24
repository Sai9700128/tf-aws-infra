# Cloud Provider Details

provider "aws" {
  profile = var.profile
  region  = var.region
}


# Create AWS VPC in us-east-1

resource "aws_vpc" "tf-aws-vpc" {
  cidr_block = var.v pc_cidr
  tags = {
    Name = "tf-aws-vpc"
  }
}



