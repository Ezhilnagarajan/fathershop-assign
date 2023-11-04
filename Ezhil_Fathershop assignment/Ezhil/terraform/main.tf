module "vpc" {
  source     = "./modules/vpc"
  name       = "demo-vpc"
  cidr_block = "10.0.0.0/16"

  ingress_rules = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
  ]

  egress_rules = [
    {
      from_port   = 0
      to_port     = 65535
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 0
      to_port     = 65535
      protocol    = "udp"
      cidr_blocks = ["0.0.0.0/0"]
    },
  ]
}

module "eks_cluster" {
  source            = "./modules/eks_cluster"
  cluster_name      = "eks-cluster"
  node_group_name   = "node-group-name"
  subnet_ids        = module.vpc.subnet_ids
  private_subnet_id = tolist([module.vpc.private_subnet_id])
}

# module "s3_bucket" {
#   source      = "./modules/s3_bucket"
#   bucket_name = "demo-bucket-php-website"
# }

module "elasticache" {
  source             = "./modules/elasticache"
  cluster_id         = "my-memcached-cluster"
  node_type          = "cache.t2.micro"
  num_cache_nodes    = 1
  subnet_group_name  = "my-cache-subnet-group"
  security_group_ids = module.vpc.sg_ids
  #security_group_ids = aws_security_group.example[*].id
}

module "rds" {
  source                  = "./modules/rds"
  allocated_storage       = 20
  instance_class          = "db.t2.micro"
  db_name                 = "wordpressdb"
  db_username             = "dbuser"
  db_password             = "password123"
  backup_retention_period = 7
  security_group_ids      = module.vpc.sg_ids
  subnet_group_name       = "subnet-group"
}

# resource "acme_certificate" "wordpress_ssl" {
#   count          = length(var.domains)
#   account_key_pem = file(var.account_key_path)
#   private_key_pem = file(var.private_key_path)
#   common_name     = var.domains[count.index]

#   dns_challenge {
#     provider = "aws"
#   }

#   timeouts = {
#     create = "5m"
#   }

#   renew_before_expiry = "1d"

# }

