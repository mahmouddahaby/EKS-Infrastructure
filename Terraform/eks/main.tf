# Create ecr
resource "aws_ecr_repository" "fsapp" {
  name = "fsapp"

  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }
}




# create the EKS cluster.
resource "aws_eks_cluster" "Fixeds" {
 name = "Fixeds-eks"
 role_arn = var.eks-role

 vpc_config {
  subnet_ids = var.subnet-id
  endpoint_private_access = true
  endpoint_public_access  = false
  security_group_ids = [ var.eks-secgrp ]
 }

 depends_on = [
  var.eks-role,
 ]
}



# create the worker nodes

 resource "aws_eks_node_group" "worker-node-group" {
  cluster_name  = aws_eks_cluster.Fixeds.name
  node_group_name = "devopsthehardway-workernodes"
  node_role_arn  =  var.worker
  subnet_ids   = var.subnet-id
  instance_types = ["t2.medium"]
 
  scaling_config {
   desired_size = 1
   max_size   = 1
   min_size   = 1
  }
 
  depends_on = [
   var.worker
  ]
 }
