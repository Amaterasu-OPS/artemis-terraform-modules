resource "tls_private_key" "pk" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "kp" {
  key_name   = "${var.cluster_name}-${var.cluster_instance_type}-key"
  public_key = tls_private_key.pk.public_key_openssh

  tags = merge(
    var.tags,
    {
      Name         = "${var.cluster_name}-${var.cluster_type}-${var.cluster_instance_type}-key"
      CostTracking = "${var.cluster_type}-${var.cluster_instance_type}"
      ResourceType = "${var.cluster_type}-${var.cluster_instance_type}-key"
      ClusterName  = var.cluster_name
      ClusterType  = var.cluster_type
      Environment  = var.environment
      ManagedBy    = "terraform"
    }
  )
}

resource "local_sensitive_file" "kp_file" {
  filename             = var.pk_file_path
  file_permission      = 400
  directory_permission = 700
  content              = tls_private_key.pk.private_key_pem
}
