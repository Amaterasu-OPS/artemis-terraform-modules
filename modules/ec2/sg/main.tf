resource "aws_security_group" "this" {
  name = "${var.cluster_name}-${var.cluster_type}-${var.cluster_instance_type}-sg"

  tags = merge(
    var.tags,
    {
      Name         = "${var.cluster_name}-${var.cluster_type}-${var.cluster_instance_type}-sg"
      CostTracking = "${var.cluster_type}-${var.cluster_instance_type}"
      ResourceType = "${var.cluster_type}-${var.cluster_instance_type}-security-group"
      ClusterName  = var.cluster_name
      ClusterType  = var.cluster_type
      Environment  = var.environment
      ManagedBy    = "terraform"
    }
  )
}

resource "aws_vpc_security_group_ingress_rule" "inbound_internal_ip" {
  security_group_id = aws_security_group.this.id
  cidr_ipv4         = "172.31.0.0/16"
  ip_protocol       = "-1"
}

resource "aws_vpc_security_group_egress_rule" "outbound_all_ipv4" {
  security_group_id = aws_security_group.this.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_vpc_security_group_egress_rule" "outbound_all_ipv6" {
  security_group_id = aws_security_group.this.id
  cidr_ipv6         = "::/0"
  ip_protocol       = "-1"
}

resource "aws_security_group_rule" "ingress" {
  for_each = {
    for idx, rule in var.allowed_rules :
    "${rule.ip}-${rule.from_port}-${rule.to_port}-${idx}" => rule
  }

  type              = "ingress"
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  protocol          = lookup(each.value, "protocol", "tcp")
  cidr_blocks       = [each.value.ip]
  security_group_id = aws_security_group.this.id
}