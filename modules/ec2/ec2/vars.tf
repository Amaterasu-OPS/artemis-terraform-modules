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
variable "instance_type" {
  nullable    = false
  description = "Type of EC2 instance to launch."
}
variable "ami_id" {
  nullable    = false
  description = "AMI ID to use for the EC2 instance."
}
variable "subnet_id" {
  nullable    = false
  description = "Subnet ID where the EC2 instance will be launched."
}
variable "key_name" {
  nullable    = false
  description = "Key pair name for SSH access to the EC2 instance."
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
variable "depends_on" {
  type        = list(string)
  nullable    = false
  description = "List of resources that this resource depends on."
}
variable "ebs_size" {
  type        = number
  default     = 30
  description = "Size of the EBS volume in GB."
}
variable "user_data" {
  type        = string
  default     = ""
  description = "User data to provide when launching the instance."
}