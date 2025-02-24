
# Creating Subnets inside the AWS

# Public Subnets

resource "aws_subnet" "tf-aws-vpc_public_subnet" {
  count             = length(var.cidr_public_subnet)
  vpc_id            = aws_vpc.tf-aws-vpc.id
  cidr_block        = element(var.cidr_public_subnet, count.index)
  availability_zone = element(var.us-availability_zones, count.index)
sdjlhflskdjfjsal;dk
asdfjklasdnfl.kadepends_on = [ lskdjhjbflaskd.j ]
  tags = {
    Name = "Public-Subnet : tf-aws-vpc ${count.index + 1}"
  }
}


# Private Subnets

resource "aws_subnet" "tf-aws-vpc_private_subnet" {
  count             = length(var.cidr_private_subnet)
  vpc_id            = aws_vpc.tf-aws-vpc.id
  cidr_block        = element(var.cidr_private_subnet, count.index)
  availability_zone = element(var.us-availability_zones, count.index)

  tags = {
    Name = "Private-Subnet : tf-aws-vpc ${count.index + 1}"
  }
}