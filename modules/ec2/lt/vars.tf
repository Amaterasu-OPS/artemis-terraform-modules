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
variable "ami_id" {
  type        = string
  nullable    = false
  description = "AMI ID to use for the launch template."
}
variable "instance_type" {
  nullable    = false
  description = "Type of EC2 instance to launch."
}
variable "key_pair_name" {
  nullable    = false
  type        = string
  description = "Key pair name for SSH access to the EC2 instance."
}
variable "user_data" {
  type        = string
  default     = ""
  description = "User data script to configure the EC2 instance on launch."
}
variable "public_ip" {
  type        = bool
  default     = false
  description = "Whether to associate a public IP address with the EC2 instance."
}
variable "security_group_ids" {
  type        = list(string)
  nullable    = false
  description = "List of security group IDs to associate with the EC2 instance."
}
variable "tags" {
  type        = map(string)
  default     = {}
  description = "A map of tags to assign to the resource."
}
variable "ebs_size" {
  type        = number
  default     = 30
  description = "Size of the EBS volume in GB."
}
variable "environment" {
  nullable    = false
  description = "The environment in which the cluster is deployed, e.g. development, staging, production."
}
variable "depends_on" {
  type        = list(string)
  nullable    = false
  default     = []
  description = "List of resources that this resource depends on."
}