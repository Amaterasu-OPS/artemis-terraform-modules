variable "desired_size" {
  type        = number
  default     = 1
  description = "Desired number of instances in the Auto Scaling group."
}
variable "min_size" {
  type        = number
  default     = 1
  description = "Minimum number of instances in the Auto Scaling group."
}
variable "max_size" {
  type        = number
  default     = 1
  description = "Maximum number of instances in the Auto Scaling group."
}
variable "region" {
  type        = string
  default     = "us-east-1"
  description = "AWS region where the Auto Scaling group will be created."
}
variable "zones" {
  type = list(string)
  validation {
    condition     = length(var.zones) > 0
    error_message = "At least one availability zone must be specified."
  }
  default     = ["a"]
  description = "List of availability zones for the Auto Scaling group."
}
variable "cluster_name" {
  type        = string
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
variable "launch_template_id" {
  type        = string
  nullable    = false
  description = "ID of the launch template to use for the Auto Scaling group."
}