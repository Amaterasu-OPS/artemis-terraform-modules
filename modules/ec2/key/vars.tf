variable "cluster_name" {
  nullable    = false
  description = "Name of the cluster."
}
variable "cluster_instance_type" {
  type        = string
  default     = "node"
  description = "Type of instance in the cluster, e.g. master, worker, node, etc."
}
variable "pk_file_path" {
  type        = string
  nullable    = false
  description = "Path where the private key file will be stored."
}