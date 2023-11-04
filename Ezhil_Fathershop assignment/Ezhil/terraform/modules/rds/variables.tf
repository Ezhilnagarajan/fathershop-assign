variable "allocated_storage" {
  description = "The amount of allocated storage (in GB) for the RDS instance"
  type        = number
}

variable "instance_class" {
  description = "The instance type for the RDS instance"
  type        = string
}

variable "db_name" {
  description = "The name of the RDS database"
  type        = string
}

variable "db_username" {
  description = "The username for the RDS database"
  type        = string
}

variable "db_password" {
  description = "The password for the RDS database"
  type        = string
}

variable "backup_retention_period" {
  description = "The number of days to retain RDS backups"
  type        = number
}

variable "security_group_ids" {
  description = "A list of security group IDs to associate with the RDS instance"
  type        = list(string)
}

variable "subnet_group_name" {
  description = "The name of the RDS subnet group"
  type        = string
}
