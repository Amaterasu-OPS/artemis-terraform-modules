variable "instance_id" {
  type        = string
  nullable    = false
  description = "ID of the instance to create the AMI from."
}
variable "scripts" {
  type        = list(string)
  nullable    = false
  default     = []
  description = "List of scripts to execute on the instance."
}
variable "instance_public_ip" {
  type        = string
  nullable    = false
  description = "Public IP address of the instance."
}
variable "pk_file_path" {
  type        = string
  nullable    = false
  description = "Path to the private key file for SSH access."
}
variable "user" {
  type        = string
  default     = "ec2-user"
  description = "Username for SSH access to the instance."
}
variable "ssh_port" {
  type        = number
  default     = 22
  description = "SSH port for connecting to the instance."
}