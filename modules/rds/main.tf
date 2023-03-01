
data "aws_subnet" "my_subnet_list" {
 tags = {
    #Name = "private data subnet"
    Name = "private data subnet az1"
  }
}

# Create the DB subnet group 
resource "aws_db_subnet_group" "my_subnet_group"{
  #subnet_ids = data.aws_subnet.my_subnet_list.id
  subnet_ids = data.aws_subnet.my_subnet_list.*.id
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
  instance_class        = var.mydb_ic
  username              = "foo"
  password              = "foobarbaz"
  skip_final_snapshot   = false
  db_subnet_group_name  = aws_db_subnet_group.my_subnet_group.id
  # vpc_security_group_ids = [aws_security_group.db.id]
}


