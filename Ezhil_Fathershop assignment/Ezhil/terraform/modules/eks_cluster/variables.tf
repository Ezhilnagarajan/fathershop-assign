variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the EKS cluster"
  type        = list(string)
}

variable "private_subnet_id" {
  description = "List of subnet IDs for the EKS cluster"
  type        = list(string)
}

variable "node_group_name" {
  description = "Name of the EKS node group"
  type        = string
}
