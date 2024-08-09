resource "aws_iam_role" "nodes_role" {
  name = "${var.cluster_name}-nodes-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
    }
  )

  tags = {
    tag-key = "nodes-${var.cluster_name}"
  }
}

resource "aws_iam_policy" "sqs_policy" {
  name        = "${var.cluster_name}-nodes-sqs-policy"
  description = "Allow permissions to use SQS"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "Statement1",
        "Effect" : "Allow",
        "Action" : [
          "sqs:GetQueueAttributes",
          "sqs:GetQueueUrl",
          "sqs:ListDeadLetterSourceQueues",
          "sqs:ListMessageMoveTasks",
          "sqs:ListQueues",
          "sqs:ListQueueTags",
          "sqs:ReceiveMessage",
          "sqs:CancelMessageMoveTask",
          "sqs:ChangeMessageVisibility",
          "sqs:DeleteMessage",
          "sqs:PurgeQueue",
          "sqs:SendMessage",
          "sqs:StartMessageMoveTask"
        ],
        "Resource" : "*"
      }
    ]
  })

  tags = {
    tag-key = "nodes-${var.cluster_name}"
  }
}

resource "aws_iam_role_policy_attachment" "worker_node_policy_att" {
  role = aws_iam_role.nodes_role.name

  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"

  depends_on = [aws_iam_role.nodes_role]

}

resource "aws_iam_role_policy_attachment" "ecr_node_police_att" {
  role       = aws_iam_role.nodes_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"

  depends_on = [aws_iam_role.nodes_role]
}

resource "aws_iam_role_policy_attachment" "cni_node_policy_att" {
  role       = aws_iam_role.nodes_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"

  depends_on = [aws_iam_role.nodes_role]

}

resource "aws_iam_role_policy_attachment" "sqs_node_policy_att" {
  role       = aws_iam_role.nodes_role.name
  policy_arn = aws_iam_policy.sqs_policy.arn

  depends_on = [aws_iam_role.nodes_role,
  aws_iam_policy.sqs_policy]

}

