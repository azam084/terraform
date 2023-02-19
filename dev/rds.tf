module "myrds" {
  source = "../modules/rds"

  mydb_name = "DBMYSQL"
  mydb_ic = "db.t3.micro"
  vpc_id = var.vpc_i
}



# db_subnet_group_name            = aws_db_subnet_group.rds_db_access.id
# # db subnet group 
# resource "aws_db_subnet_group" "aws_db_access" {
#   count = var.rds_instance_count

#   name        = "rds"
#   description = "rds"
#   subnet_ids  = "[sub-i25]"
# }
