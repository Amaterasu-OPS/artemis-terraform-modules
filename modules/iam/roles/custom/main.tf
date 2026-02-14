resource "aws_iam_policy" "this" {
  name   = "${var.cluster_name}-${var.cluster_type}-${var.cluster_instance_type}-policy-access"
  policy = var.policy

  tags = merge(
    var.tags,
    {
      Name         = "${var.cluster_name}-${var.cluster_type}-${var.cluster_instance_type}-policy-access"
      CostTracking = "${var.cluster_type}-${var.cluster_instance_type}"
      ResourceType = "${var.cluster_type}-${var.cluster_instance_type}-iam-policy"
      ClusterName  = var.cluster_name
      ClusterType  = var.cluster_type
      Environment  = var.environment
      ManagedBy    = "terraform"
    },
  )
}

resource "aws_iam_role_policy_attachment" "this" {
  role       = var.ec2_role_name
  policy_arn = aws_iam_policy.this.arn
}
