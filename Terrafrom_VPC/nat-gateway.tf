# # First I need to create an Elastic IP address

# resource "aws_eip" "nat_eip" {
#   count = length(var.cidr_private_subnet)
#   vpc   = "true"
#   tags = {
#     Name = "Elastic Ip for tf-aws-vpc  ${count.index + 1}"
#   }
# }

# resource "aws_nat_gateway" "nat_gateway" {
#   count         = length(var.cidr_private_subnet)
#   depends_on    = [aws_eip.nat_eip]
#   allocation_id = aws_eip.nat_eip[count.index].id
#   subnet_id     = aws_subnet.tf-aws-vpc_private_subnet[count.index].id
#   tags = {
#     Name = "Private NAT Gateway : For tf-aws-vpc"
#   }
# }
