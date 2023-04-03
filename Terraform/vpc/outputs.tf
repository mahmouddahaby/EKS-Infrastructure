output "subnet-id-0" {
  value = aws_subnet.subnets[0].id
}
output "subnet-id-1" {
  value = aws_subnet.subnets[1].id
}
output "vpc_id" {
  value = aws_vpc.eks-vpc.id
}