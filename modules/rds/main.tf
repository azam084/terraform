  resource "aws_db_subnet_group" "aws_db_access" {
  count = var.rds_instance_count

  name        = "rds"
  description = "rds"
  subnet_ids  = "[subnet-0def2419710bdfe5c]"
}

resource "aws_db_instance" "myrds" {
  allocated_storage    = 10
  db_name              = var.mydb_name
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = var.mydb_ic
  username             = "foo"
  password             = "foobarbaz"
  parameter_group_name = "myrds.mysql5.7"
  skip_final_snapshot  = true
  db_subnet_group_name = aws_db_subnet_group.aws_db_access
}