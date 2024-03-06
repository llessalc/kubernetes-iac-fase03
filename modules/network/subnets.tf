# The following tags
# are needed to add load balancers in the subnets
# public: kubernetes.io/role/elb
# private: kubernetes.io/role/internal-elb

# If the load balancer version is <= 2.1.1
# then the tag kubernetes.io/cluster/my-cluster
# needs to be added too

resource "aws_subnet" "private-a" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.0.0/19"
  availability_zone = "us-east-1a"

  tags = {
    "Name"                                                  = "${var.priv_subnet_name}-${var.region_name}a"
    "kubernetes.io/role/internal-elb"                       = "1"
    "kubernetes.io/cluster/${var.cluster_name}-eks-cluster" = "shared"
  }
  depends_on = [aws_vpc.vpc]
}

resource "aws_subnet" "private-b" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.32.0/19"
  availability_zone = "us-east-1b"

  tags = {
    "Name"                                                  = "${var.priv_subnet_name}-${var.region_name}b"
    "kubernetes.io/role/internal-elb"                       = "1"
    "kubernetes.io/cluster/${var.cluster_name}-eks-cluster" = "shared"
  }
  depends_on = [aws_vpc.vpc]
}

resource "aws_subnet" "public-a" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.64.0/19"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    "Name"                                                  = "${var.pub_subnet_name}-${var.region_name}a"
    "kubernetes.io/role/elb"                                = "1"
    "kubernetes.io/cluster/${var.cluster_name}-eks-cluster" = "shared"
  }
  depends_on = [aws_vpc.vpc]
}

resource "aws_subnet" "public-b" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.96.0/19"
  availability_zone = "us-east-1b"
  #public
  map_public_ip_on_launch = true

  tags = {
    "Name"                                                  = "${var.pub_subnet_name}-${var.region_name}b"
    "kubernetes.io/role/elb"                                = "1"
    "kubernetes.io/cluster/${var.cluster_name}-eks-cluster" = "shared"
  }

  depends_on = [aws_vpc.vpc]
}
