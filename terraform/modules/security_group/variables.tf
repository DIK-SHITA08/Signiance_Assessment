variable "vpc_id" {
  description = "VPC ID where security group will be created"
  type        = string
}

variable "sg_name" {
  description = "Name of the security group"
  type        = string
  default     = "sg-module"
}

variable "description" {
  description = "Description of the security group"
  type        = string
  default     = "Security group created by module"
}

variable "tags" {
  description = "Tags to apply to the security group"
  type        = map(string)
  default     = {}
}
