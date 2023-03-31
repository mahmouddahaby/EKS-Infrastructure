resource "aws_vpc" "eks-vpc" {
  cidr_block = var.cidr-vpc

  tags = {
    "Name" = var.name-vpc
  }
}

resource "aws_subnet" "subnets" {
  count = length(var.subnet-cidr)
  vpc_id     = aws_vpc.eks-vpc.id
  cidr_block = var.subnet-cidr[count.index]
  availability_zone = var.az-subnet[count.index]
  map_public_ip_on_launch = true
}

