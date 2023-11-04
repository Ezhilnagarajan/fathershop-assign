variable "cluster_id" {
  description = "The ID for the Elasticache Memcached cluster"
  type        = string
}

variable "node_type" {
  description = "The type of Elasticache Memcached nodes"
  type        = string
}

variable "num_cache_nodes" {
  description = "The number of cache nodes in the cluster"
  type        = number
}

variable "subnet_group_name" {
  description = "The name of the cache subnet group"
  type        = string
}

variable "security_group_ids" {
  description = "A list of security group IDs to associate with the Memcached cluster"
  type        = list(string)
}
