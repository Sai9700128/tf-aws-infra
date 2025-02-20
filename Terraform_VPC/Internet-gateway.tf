

# creating Internet Gateway

resource "aws_internet_gateway" "public_internet_gateway" {
  vpc_id = aws_vpc.tf-aws-vpc.id
  tags = {
    Name = "IGW: For tf-aws-vpc"
  }
}