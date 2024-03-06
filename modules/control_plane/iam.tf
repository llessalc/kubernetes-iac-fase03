resource "aws_iam_role" "eks_role" {
  name = var.eks_role_name

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    tag-key = "eks-${var.cluster_name}"
  }
}


resource "aws_iam_role_policy_attachment" "eks_cluster_policy_att" {
  role       = aws_iam_role.eks_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"

  depends_on = [aws_iam_role.eks_role]
}
