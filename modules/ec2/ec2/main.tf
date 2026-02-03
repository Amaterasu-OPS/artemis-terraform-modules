resource "aws_instance" "this" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = var.security_group_ids
  depends_on                  = var.depends_on
  key_name                    = var.key_name
  associate_public_ip_address = var.public_ip
  user_data                   = var.user_data != "" ? base64decode(var.user_data) : null

  metadata_options {
    http_tokens = "required"
  }

  root_block_device {
    device_name           = "/dev/sda1"
    volume_type           = "gp3"
    volume_size           = var.ebs_size
    encrypted             = true
    delete_on_termination = true
    iops                  = 3000
    throughput            = 125
  }

  tags = merge(
    var.tags,
    {
      Name         = "${var.cluster_name}-${var.cluster_instance_type}"
      CostTracking = "${var.cluster_type}-${var.cluster_instance_type}"
      ClusterName  = var.cluster_name
      ClusterType  = var.cluster_type
      Environment  = var.environment
      ManagedBy    = "terraform"
    }
  )
}
