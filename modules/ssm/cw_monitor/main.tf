resource "aws_ssm_parameter" "cw_agent_config" {
  name = "/cw_agent/config/${var.cluster_name}/${var.cluster_type}/${var.cluster_instance_type}"
  type = "String"

  value = jsonencode({
    metrics = {
      namespace = "CWAgent"
      append_dimensions = {
        InstanceId = "${var.instance_id}"
      }
      metrics_collected = {
        mem = {
          measurement = ["mem_used_percent"]
        }
        disk = {
          measurement = ["used_percent"]
          resources   = ["*"]
        }
      }
    }
  })
}

resource "aws_ssm_association" "cw_agent_install" {
  name = "${var.cluster_name}-${var.cluster_type}-${var.cluster_instance_type}-cw-agent-install"

  targets {
    key    = "tag:Name"
    values = ["${var.cluster_name}-${var.cluster_type}-${var.cluster_instance_type}"]
  }

  parameters = {
    action                        = ["configure"]
    mode                          = ["ec2"]
    optionalConfigurationSource   = ["ssm"]
    optionalConfigurationLocation = [aws_ssm_parameter.cw_agent_config.name]
    optionalRestart               = ["yes"]
  }
}