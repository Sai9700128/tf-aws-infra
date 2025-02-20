# Route_Table Association to Subnet

# Public route table Association

resource "aws_route_table_association" "public_subnet_association"{
    count = length(var.cidr_public_subnet)
    depends_on = [aws_subnet.tf-aws-vpc_public_subnet,aws_route_table.tf-aws-vpc-public_route_table]
    subnet_id = element(aws_subnet.tf-aws-vpc_public_subnet[*].id,count.index)
    route_table_id = aws_route_table.tf-aws-vpc-public_route_table.id
}



# Private route table Association

resource "aws_route_table_association" "private_subnet_association"{
    count = length(var.cidr_private_subnet)
    depends_on = [aws_subnet.tf-aws-vpc_private_subnet,aws_route_table.tf-aws-vpc-private_route_table]
    subnet_id = element(aws_subnet.tf-aws-vpc_private_subnet[*].id,count.index)
    route_table_id = aws_route_table.tf-aws-vpc-private_route_table[count.index].id
}

