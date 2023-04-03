# Create ecr
resource "aws_ecr_repository" "my_repo" {
  name = "my-repo"

  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }
}





# create the EKS cluster.
resource "aws_eks_cluster" "Fixeds" {
 name = "Fixeds-eks"
 role_arn = var.eks-iam-role

 vpc_config {
  subnet_ids = var.subnet-id
  endpoint_private_access = true
  endpoint_public_access  = false
  security_group_ids = [ var.eks-secgrp ]
 }

 depends_on = [
  var.eks-iam-role,
 ]
}




# create the worker nodes

 resource "aws_eks_node_group" "worker-node-group" {
  cluster_name  = aws_eks_cluster.Fixeds.name
  node_group_name = "devopsthehardway-workernodes"
  node_role_arn  = var.worker-iam-role
  subnet_ids   = var.subnet-id
  instance_types = ["t2.medium"]
 
  scaling_config {
   desired_size = 2
   max_size   = 2
   min_size   = 1
  }
 
  depends_on = [
   var.worker-iam-role,
  ]
 }
