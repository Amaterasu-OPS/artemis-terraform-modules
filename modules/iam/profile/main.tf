resource "aws_iam_instance_profile" "profile" {
  name = "${var.cluster_name}-${var.cluster_type}-${var.cluster_instance_type}-iam-profile"
  role = var.ec2_role_name

  tags = merge(
    var.tags,
    {
      Name         = "${var.cluster_name}-${var.cluster_type}-${var.cluster_instance_type}-iam-profile"
      CostTracking = "${var.cluster_type}-${var.cluster_instance_type}"
      ResourceType = "${var.cluster_type}-${var.cluster_instance_type}-iam-profile"
      ClusterName  = var.cluster_name
      ClusterType  = var.cluster_type
      Environment  = var.environment
      ManagedBy    = "terraform"
    }
  )
}