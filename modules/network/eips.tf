# Each NAT Gateway needs an eip

resource "aws_eip" "eip1" {
  domain = "vpc"

  tags = {
    Name = "${var.eip_name}-a"
  }
  depends_on = [aws_internet_gateway.igw]
}

resource "aws_eip" "eip2" {
  domain = "vpc"

  tags = {
    Name = "${var.eip_name}-b"
  }
  depends_on = [aws_internet_gateway.igw]
}
