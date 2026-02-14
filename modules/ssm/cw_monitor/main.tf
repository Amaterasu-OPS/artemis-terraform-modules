data "template_file" "this" {
  template = file("${path.module}/cw_agent_config.json")

  vars = {
    log_group_name = "/ec2/${var.cluster_name}/${var.cluster_type}/${var.cluster_instance_type}"
  }
}

resource "aws_ssm_parameter" "this" {
  name  = "/cloudwatch-agent/config/${var.cluster_name}/${var.cluster_type}/${var.cluster_instance_type}"
  type  = "String"
  value = data.template_file.this.rendered
}