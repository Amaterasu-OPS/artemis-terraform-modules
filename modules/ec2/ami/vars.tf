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
variable "instance_id" {
  type        = string
  nullable    = false
  description = "ID of the instance to create the AMI from."
}
variable "depends_on" {
  type        = list(string)
  nullable    = false
  default     = []
  description = "List of resources that this resource depends on."
}
variable "tags" {
  type        = map(string)
  default     = {}
  description = "A map of tags to assign to the resource."
}
variable "environment" {
  nullable    = false
  description = "The environment in which the cluster is deployed, e.g. development, staging, production."
}