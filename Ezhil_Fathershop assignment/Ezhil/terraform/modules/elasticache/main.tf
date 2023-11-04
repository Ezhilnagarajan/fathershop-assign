resource "aws_elasticache_cluster" "memcached" {
  cluster_id           = "demo-cluster"
  engine               = "memcached"
  engine_version       = "1.6.6"
  node_type            = "cache.t2.micro"
  num_cache_nodes      = 1
  parameter_group_name = aws_elasticache_parameter_group.custom_memcached_parameter_group.id
  port                 = 11211
}

resource "aws_elasticache_parameter_group" "custom_memcached_parameter_group" {
  name        = "custom-memcached-parameter-group"
  family      = "memcached1.6"
  description = "Custom Memcached Parameter Group"

  # parameter {
  #   name  = "php-website"
  #   value = "enabled"
  # }
}

