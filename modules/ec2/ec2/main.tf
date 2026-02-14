resource "aws_instance" "this" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = var.security_group_ids
  depends_on                  = [var.dependencies]
  key_name                    = var.key_name
  associate_public_ip_address = var.public_ip
  user_data                   = "${data.local_file.script.content}${var.user_data != "" ? var.user_data : ""}"
  iam_instance_profile        = var.iam_instance_profile
  monitoring                  = true

  metadata_options {
    http_tokens = "required"
  }

  root_block_device {
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
      Name         = "${var.cluster_name}-${var.cluster_type}-${var.cluster_instance_type}"
      CostTracking = "${var.cluster_type}-${var.cluster_instance_type}"
      ResourceType = "${var.cluster_type}-${var.cluster_instance_type}-ec2-instance"
      ClusterName  = var.cluster_name
      ClusterType  = var.cluster_type
      Environment  = var.environment
      ManagedBy    = "terraform"
    }
  )
}

data "template_file" "script" {
  template = file("${path.module}/ec2_base.sh")

  vars = {
    cluster_name          = var.cluster_name
    cluster_type          = var.cluster_type
    cluster_instance_type = var.cluster_instance_type
  }
}

resource "aws_cloudwatch_log_group" "this" {
  name              = "/ec2/${var.cluster_name}/${var.cluster_type}/${var.cluster_instance_type}"
  retention_in_days = 7
}

data "template_file" "this" {
  template = file("${path.module}/cw_agent_config.json")

  vars = {
    log_group_name = "/ec2/${var.cluster_name}/${var.cluster_type}/${var.cluster_instance_type}"
  }
}