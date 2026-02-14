resource "aws_iam_user" "this" {
  name = "${var.cluster_name}-${var.cluster_type}-${var.cluster_instance_type}-usr"

  tags = merge(
    var.tags,
    {
      Name         = "${var.cluster_name}-${var.cluster_type}-${var.cluster_instance_type}-usr"
      CostTracking = "${var.cluster_type}-${var.cluster_instance_type}"
      ResourceType = "${var.cluster_type}-${var.cluster_instance_type}-iam-user"
      ClusterName  = var.cluster_name
      ClusterType  = var.cluster_type
      Environment  = var.environment
      ManagedBy    = "terraform"
    },
  )
}

resource "aws_iam_access_key" "this" {
  user = aws_iam_user.this.name
}

resource "aws_iam_group" "this" {
  name = "${var.cluster_name}-${var.cluster_type}-${var.cluster_instance_type}-usr-gr"
}

resource "aws_iam_group_membership" "this" {
  name  = aws_iam_user.this.name
  users = [aws_iam_user.this.name]
  group = aws_iam_group.this.name
}

resource "aws_iam_policy" "this" {
  name   = "${var.cluster_name}-${var.cluster_type}-${var.cluster_instance_type}-policy"
  policy = var.policy

  tags = merge(
    var.tags,
    {
      Name         = "${var.cluster_name}-${var.cluster_type}-${var.cluster_instance_type}-policy"
      CostTracking = "${var.cluster_type}-${var.cluster_instance_type}"
      ResourceType = "${var.cluster_type}-${var.cluster_instance_type}-iam-policy"
      ClusterName  = var.cluster_name
      ClusterType  = var.cluster_type
      Environment  = var.environment
      ManagedBy    = "terraform"
    },
  )
}

resource "aws_iam_group_policy_attachment" "this" {
  policy_arn = aws_iam_policy.this.arn
  group      = aws_iam_group.this.name
}
