
resource "aws_eks_cluster" "eks_cluster" {
  name = "${var.cluster_name}-eks-cluster"

  role_arn = aws_iam_role.eks_role.arn

  vpc_config {
    endpoint_private_access = false

    endpoint_public_access = true

    subnet_ids = [
      var.subnet_priv-a_id,
      var.subnet_priv-b_id,
      var.subnet_pub-a_id,
      var.subnet_pub-b_id
    ]
  }

  tags = {
    "kubernetes.io/cluster/${var.cluster_name}-eks-cluster" : "owned"
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_policy_att
  ]
}
