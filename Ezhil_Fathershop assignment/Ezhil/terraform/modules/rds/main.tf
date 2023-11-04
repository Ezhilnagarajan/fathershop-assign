resource "aws_db_instance" "wordpress_db" {
  allocated_storage    = 10
  db_name              = "mydb"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  username             = "ezhil"
  password             = "ezhil123"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
}
