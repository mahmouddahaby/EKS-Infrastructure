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

resource "aws_security_group" "eks_cluster" {
  name_prefix = "eks_cluster_"
  description = "Security group for EKS cluster"
  vpc_id = var.vpc-id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


# Create Security group for ec2 instance

resource "aws_security_group" "ec2-sg" {
  name_prefix = "example-sg"
  vpc_id = var.vpc-id
  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}