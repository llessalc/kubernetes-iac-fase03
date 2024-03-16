resource "aws_eks_node_group" "node_group" {
  cluster_name    = var.cluster_name
  node_group_name = "${var.cluster_name}-managed-node-group"

  node_role_arn = aws_iam_role.nodes_role.arn

  subnet_ids = [
    var.subnet_priv-a_id,
    var.subnet_priv-b_id
  ]

  ami_type             = "AL2_x86_64"
  capacity_type        = "SPOT" #SAVE MONEY
  disk_size            = 20
  force_update_version = false

  instance_types = ["t3.micro"]

  scaling_config {
    desired_size = 4
    max_size     = 4
    min_size     = 1
  }

  labels = {
    role = "nodes-${var.cluster_name}"
  }



  depends_on = [
    aws_iam_role_policy_attachment.cni_node_policy_att,
    aws_iam_role_policy_attachment.ecr_node_police_att,
    aws_iam_role_policy_attachment.worker_node_policy_att
  ]
}
