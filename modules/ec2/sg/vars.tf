variable "cluster_name" {
  nullable    = false
  description = "Name of the cluster."
}
variable "cluster_instance_type" {
  type        = string
  default     = "node"
  description = "Type of instance in the cluster, e.g. master, worker, node, etc."
}
variable "cluster_type" {
  type        = string
  nullable    = false
  description = "Type of cluster, e.g. Clickhouse, PostgreSQL, Druid."
}
variable "environment" {
  nullable    = false
  description = "The environment in which the cluster is deployed, e.g. development, staging, production."
}
variable "tags" {
  type        = map(string)
  default     = {}
  description = "A map of tags to assign to the resource."
}
variable "allowed_rules" {
  description = "List of allowed ingress rules for the security group. Each rule should include an IP (CIDR), from_port, to_port, and optionally a protocol (default is tcp)."
  type = list(object({
    ip        = string
    from_port = number
    to_port   = number
    protocol  = optional(string, "tcp")
  }))
  validation {
    condition = alltrue([
      for r in var.allowed_rules :
      can(cidrhost(r.ip, 0)) &&
      r.from_port <= r.to_port &&
      r.from_port >= 0 &&
      r.to_port <= 65535
    ])
    error_message = "Each allowed rule must have a valid CIDR IP, from_port must be less than or equal to to_port, and ports must be between 0 and 65535."
  }
}