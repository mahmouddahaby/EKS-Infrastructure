# Create ecr
resource "aws_ecr_repository" "FS-app" {
  name = "FS-app"

  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }
}




#Set up the first resource for the IAM role
resource "aws_iam_role" "eks-iam-role" {
 name = "Fixeds-eks-iam-role"

 path = "/"

 assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
  {
   "Effect": "Allow",
   "Principal": {
    "Service": "eks.amazonaws.com"
   },
   "Action": "sts:AssumeRole"
  }
 ]
}
EOF

}

# The two policies allow you to properly access EC2 instances
resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy" {
 policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
 role    = aws_iam_role.eks-iam-role.name
}
resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly-EKS" {
 policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
 role    = aws_iam_role.eks-iam-role.name
}
# Allow EKS cluster access to ECR registry
resource "aws_iam_policy" "ecr-cluster-access" {
  name        = "eks-ecr-access"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:GetRepositoryPolicy",
          "ecr:DescribeRepositories",
          "ecr:ListImages",
          "ecr:DescribeImages",
          "ecr:BatchGetImage",
          "ecr:GetLifecyclePolicy",
          "ecr:GetLifecyclePolicyPreview",
          "ecr:ListTagsForResource",
          "ecr:DescribeImageScanFindings",
          "ecr:InitiateLayerUpload",
          "ecr:UploadLayerPart",
          "ecr:CompleteLayerUpload",
          "ecr:PutImage",
          "ecr:DeleteRepository",
          "ecr:BatchDeleteImage",
          "ecr:SetRepositoryPolicy",
          "ecr:TagResource",
          "ecr:UntagResource",
          "ecr:GetRegistryPolicy",
          "ecr:PutRegistryPolicy"
        ]
        Resource = "*"
      }
    ]
  })
}

# Attach the ECR access policy to the EKS role
resource "aws_iam_role_policy_attachment" "ecr-cluster-access" {
  policy_arn = aws_iam_policy.ecr-cluster-access.arn
  role       = aws_iam_role.eks-iam-role.name
}



# create the EKS cluster.
resource "aws_eks_cluster" "Fixeds" {
 name = "Fixeds-eks"
 role_arn = aws_iam_role.eks-iam-role.arn

 vpc_config {
  subnet_ids = var.subnet-id
  endpoint_private_access = true
  endpoint_public_access  = false
  security_group_ids = [ var.eks-secgrp ]
 }

 depends_on = [
  aws_iam_role.eks-iam-role,
 ]
}




# Set up an IAM role for the worker nodes.
resource "aws_iam_role" "workernodes" {
  name = "eks-node-group-example"
 
  assume_role_policy = jsonencode({
   Statement = [{
    Action = "sts:AssumeRole"
    Effect = "Allow"
    Principal = {
     Service = "ec2.amazonaws.com"
    }
   }]
   Version = "2012-10-17"
  })
 }
 
 resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role    = aws_iam_role.workernodes.name
 }
 
 resource "aws_iam_role_policy_attachment" "AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role    = aws_iam_role.workernodes.name
 }
 
 resource "aws_iam_role_policy_attachment" "EC2InstanceProfileForImageBuilderECRContainerBuilds" {
  policy_arn = "arn:aws:iam::aws:policy/EC2InstanceProfileForImageBuilderECRContainerBuilds"
  role    = aws_iam_role.workernodes.name
 }
 
 resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role    = aws_iam_role.workernodes.name
 }


# create the worker nodes

 resource "aws_eks_node_group" "worker-node-group" {
  cluster_name  = aws_eks_cluster.Fixeds.name
  node_group_name = "devopsthehardway-workernodes"
  node_role_arn  = aws_iam_role.workernodes.arn
  subnet_ids   = var.subnet-id
  instance_types = ["t2.medium"]
 
  scaling_config {
   desired_size = 2
   max_size   = 2
   min_size   = 1
  }
 
  depends_on = [
   aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
   aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
   #aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
  ]
 }
