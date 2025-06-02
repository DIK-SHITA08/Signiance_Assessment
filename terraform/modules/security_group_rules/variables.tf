variable "type" {
  description = "Type of rule: ingress or egress"
  type        = string
}

variable "from_port" {
  type = number
}

variable "to_port" {
  type = number
}

variable "protocol" {
  type = string
}

variable "cidr_blocks" {
  type = list(string)
}

variable "security_group_id" {
  type = string
}

variable "description" {
  type = string
}
