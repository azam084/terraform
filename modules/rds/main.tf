#   resource "aws_db_subnet_group" "aws_db_access" {
#   #count = var.rds_instance_count

#   name        = "rds"
#   description = "rds"
#   subnet_ids  = "[subnet-0def2419710bdfe5c]"
# }

#create security group for the EC2 instance

data "aws_vpc" "selected" {
 filter {
   name = "tag:Name"
   values = ["DEV_ENV-vpc"]
 }
}

resource "aws_db_instance" "myrds" {
  allocated_storage    = var.allocated_storage
  #vpc_id = data.aws_vpc.selected.id
  db_name              = var.mydb_name
  engine            = var.db_engine
  engine_version    = var.db_engine_version
  instance_class       = var.mydb_ic
  username             = "foo"
  password             = "foobarbaz"
  #parameter_group_name = "myrds.mysql5.7"
  skip_final_snapshot  = true
  #db_subnet_group_name = aws_db_subnet_group.aws_db_access
}