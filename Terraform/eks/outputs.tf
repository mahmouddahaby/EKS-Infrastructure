# output "eks" {
#   value = aws_eks_cluster.fs-eks.id
# }

output "worker" {
  value = aws_eks_node_group.worker-node-group.id
}