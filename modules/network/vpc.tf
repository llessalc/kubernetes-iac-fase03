resource "aws_vpc" "vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  # The VPC must have DNS hostname and DNS resolution support.
  # Otherwise, nodes can't register to your cluster. 
  # For more information, see DNS attributes for your VPC in
  # the Amazon VPC User Guide.
  # https://docs.aws.amazon.com/eks/latest/userguide/network_reqs.html

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name      = var.vpc_name
    terraform = "true"
  }
}
