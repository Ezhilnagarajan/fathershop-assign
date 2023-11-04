output "elasticache_cluster_id" {
  description = "The ID of the Elasticache Memcached cluster"
  value       = aws_elasticache_cluster.memcached.id
}
