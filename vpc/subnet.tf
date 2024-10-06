
resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.main.id
  count             = length(var.public_subnet_cidr)
  cidr_block        = element(var.public_subnet_cidr, count.index)
  availability_zone = element(var.zone, count.index)
  tags = {
    Name        = "${var.env}-public-${count.index + 1}"
    Environment = "${var.env}"
  }
}

resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.main.id
  count             = length(var.private_subnet_cidr)
  cidr_block        = element(var.private_subnet_cidr, count.index)
  availability_zone = element(var.zone, count.index)
  tags = {
    Name        = "${var.env}-private-${count.index + 1}"
    Environment = "${var.env}"
  }
}

