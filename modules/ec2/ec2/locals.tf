locals {
  ssm_parameter_name = "/cloudwatch-agent/config/${var.cluster_name}/${var.cluster_type}/${var.cluster_instance_type}"
  cw_log_group_name  = "/ec2/${var.cluster_name}/${var.cluster_type}/${var.cluster_instance_type}"

  script = templatefile("${path.module}/ec2_base.sh", {
    ssm_parameter_name = "ssm:${locals.ssm_parameter_name}"
  })

  cw_config = templatefile("${path.module}/cw_agent_config.json", {
    log_group_name = locals.cw_log_group_name
  })
}
