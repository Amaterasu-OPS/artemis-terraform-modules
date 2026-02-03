resource "aws_security_group" "this" {
  name = "${var.cluster_name}-${var.cluster_instance_type}-sg"

  tags = merge(
    var.tags,
    {
      Name         = "${var.cluster_name}-${var.cluster_instance_type}-sg"
      CostTracking = "${var.cluster_type}-resources"
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