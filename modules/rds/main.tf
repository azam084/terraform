data "aws_subnet" "my_subnet_list" {
 tags = {
    sidg = "RDS_Subnet"
  }
}



# Create the DB subnet group 
resource "aws_db_subnet_group" "my_subnet_group"{
  for_each = data.aws_subnet.my_subnet_list.id
  subnet_ids = each.value
  #subnet_ids = data.aws_subnet.my_subnet_list.id
  #subnet_ids = [data.aws_subnet.my_subnet_list]
  #subnet_ids = flatten([data.aws_subnet.my_subnet_list.*.id])
  # tags = {
  #   Name = "${var.project_name}-Subnet Group"
  # }
}


# create RDS 
resource "aws_db_instance" "myrds" {
  allocated_storage     = var.allocated_storage
  db_name               = var.mydb_name
  engine                = var.db_engine
  engine_version        = var.db_engine_version
  instance_class        = "db.m5.large"
  username              = "foo"
  password              = "foobarbaz"
  #final_snapshot_identifier = 
  skip_final_snapshot   = true
  #multi_az = false
  #db_subnet_group_name  = aws_db_subnet_group.my_subnet_group.id
  # vpc_security_group_ids = [aws_security_group.db.id]
}


