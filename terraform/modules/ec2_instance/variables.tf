variable "region" {
  description = "AWS region"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "key_name" {
  description = "Name of the key pair used"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}
variable "subnet_id" {
  description = "Subnet ID"
  type        = string
}

variable "ami_id" {
  description = "AMI ID"
  type        = string
}

variable "tags" {
  type = map(string)
}

variable "security_group_ids" {
  type = list(string)
}