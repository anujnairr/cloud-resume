resource "aws_eip" "nat_eip" {
  domain = "vpc"
  tags = {
    Name        = "${var.env}-eip"
    Environment = "${var.env}"
  }
}

resource "aws_nat_gateway" "natgw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = element(var.public_subnet_cidr, 0)
  depends_on    = [aws_internet_gateway.igw]
  tags = {
    Name        = "${var.env}-natgateway"
    Environment = "${var.env}"
  }
}

