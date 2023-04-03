output "eks-iam-role" {
  value = aws_iam_role.eks-iam-role.arn
}

output "woeker-iam-role" {
  value = aws_iam_role.workernodes.arn
}