resource "aws_nat_gateway" "nat1" {
  allocation_id = aws_eip.eip1.id
  subnet_id     = aws_subnet.public-a.id

  tags = {
    Name = "${var.nat_name}-a"
  }

  depends_on = [aws_internet_gateway.igw]
}


resource "aws_nat_gateway" "nat2" {
  allocation_id = aws_eip.eip2.id
  subnet_id     = aws_subnet.public-b.id

  tags = {
    Name = "${var.nat_name}-b"
  }

  depends_on = [aws_internet_gateway.igw]
}
