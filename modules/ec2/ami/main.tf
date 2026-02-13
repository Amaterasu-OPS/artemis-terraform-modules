resource "aws_ami_from_instance" "this" {
  depends_on = var.depends_on

  name               = "${var.cluster_name}-${var.cluster_instance_type}-${var.cluster_type}-ami"
  source_instance_id = var.instance_id

  tags = merge(
    var.tags,
    {
      Name         = "${var.cluster_name}-${var.cluster_instance_type}-${var.cluster_type}-ami"
      CostTracking = "${var.cluster_type}-${var.cluster_instance_type}"
      ResourceType = "${var.cluster_type}-${var.cluster_instance_type}-ec2-ami"
      ClusterName  = var.cluster_name
      ClusterType  = var.cluster_type
      Environment  = var.environment
      ManagedBy    = "terraform"
    }
  )
}