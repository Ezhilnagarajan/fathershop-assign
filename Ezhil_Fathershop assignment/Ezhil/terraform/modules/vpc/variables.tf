variable "name" {
  type        = string
  description = "A name for this network."
}

variable "cidr_block" {
  type        = string
  description = "The CIDR block for the VPC."
}

variable "ingress_rules" {
  description = "A list of ingress rules for the security group."
  type        = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}

variable "egress_rules" {
  description = "A list of egress rules for the security group."
  type        = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}
