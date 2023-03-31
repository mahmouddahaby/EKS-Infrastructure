resource "aws_internet_gateway" "igw" {
  vpc_id = var.vpc-id
}

resource "aws_route_table" "public" {
  vpc_id = var.vpc-id
  tags = {
    "key" = "route table"
  }
}

resource "aws_route" "public" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "public" {
  subnet_id      = var.subnets[0]
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public-1" {
  subnet_id      = var.subnets[1]
  route_table_id = aws_route_table.public.id
}