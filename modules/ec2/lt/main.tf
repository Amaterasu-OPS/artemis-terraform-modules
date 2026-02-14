resource "aws_launch_template" "this" {
  name_prefix   = "${var.cluster_name}--${var.cluster_type}-${var.cluster_instance_type}-lt"
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_pair_name
  depends_on    = var.dependencies

  network_interfaces {
    associate_public_ip_address = var.public_ip
    security_groups             = var.security_group_ids
  }

  block_device_mappings {
    device_name = "/dev/sda1"

    ebs {
      volume_size           = var.ebs_size
      volume_type           = "gp3"
      delete_on_termination = true
      encrypted             = true
      iops                  = 3000
      throughput            = 125
    }
  }

  user_data = base64encode(var.user_data)

  tag_specifications {
    resource_type = "instance"

    tags = merge(
      var.tags,
      {
        Name         = "${var.cluster_name}-${var.cluster_type}-${var.cluster_instance_type}-lt"
        CostTracking = "${var.cluster_type}-${var.cluster_instance_type}"
        ResourceType = "${var.cluster_type}-${var.cluster_instance_type}-launch-template"
        ClusterName  = var.cluster_name
        ClusterType  = var.cluster_type
        Environment  = var.environment
        ManagedBy    = "terraform"
      }
    )
  }

  lifecycle {
    create_before_destroy = true
  }
}