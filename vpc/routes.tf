
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name        = "${var.env}-public-route-table"
    Environment = "${var.env}"
  }
}

# resource "aws_route_table" "private" {
#   vpc_id = aws_vpc.main.id

#   route {
#     cidr_block     = "0.0.0.0/0"
#     nat_gateway_id = aws_nat_gateway.natgw.id
#   }
#   tags = {
#     Name        = "${var.env}-private-route-table"
#     Environment = "${var.env}"
#   }
# }

# resource "aws_route_table_association" "private" {
#   route_table_id = aws_route_table.private.id
#   subnet_id      = element(aws_subnet.private[*].id, count.index)
#   count          = length(var.private_subnet_cidr)
# }

resource "aws_route_table_association" "public" {
  route_table_id = aws_route_table.public.id
  subnet_id      = element(aws_subnet.public[*].id, count.index)
  count          = length(var.public_subnet_cidr)
}

