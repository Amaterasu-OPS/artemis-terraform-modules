resource "aws_autoscaling_group" "this" {
  desired_capacity   = var.desired_size
  max_size           = var.max_size
  min_size           = var.min_size
  health_check_type  = "EC2"
  availability_zones = [for zone in var.zones : "${var.region}${zone}"]
  name               = "${var.cluster_name}-${var.cluster_type}-${var.cluster_instance_type}-asg"

  launch_template {
    id      = var.launch_template_id
    version = "$Latest"
  }
}