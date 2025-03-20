
# Public Route Table

resource "aws_route_table" "tf-aws-vpc-public_route_table" {
  vpc_id = aws_vpc.tf-aws-vpc.id
  route {
    cidr_block = var.cidr_block
    gateway_id = aws_internet_gateway.public_internet_gateway.id
  }
  tags = {
    Name = "Public Route Table: For tf-aws-vpc-public_subnets"
  }
}


# Private Route Table

# resource "aws_route_table" "tf-aws-vpc-private_route_table" {
#   count  = length(var.cidr_private_subnet)
#   vpc_id = aws_vpc.tf-aws-vpc.id
#   # depends_on = [aws_nat_gateway.nat_gateway]
#   route {
#     cidr_block = var.cidr_block
#     # nat_gateway_id = aws_nat_gateway.nat_gateway[count.index].id
#   }
#   tags = {
#     Name = "Private Route Table: For tf-aws-vpc"
#   }
# }
