
data "aws_subnet" "my_subnet_list" {
  count             = 2
  availability_zone = "eu-west-1${element(["a", "b"], count.index)}"
  tags = {
    sidg = "RDS_Subnet"
  }
}

resource "aws_db_subnet_group" "my_subnet_group"{
  name        = "my-subnet-group"
  description = "My subnet group"
  subnet_ids  = [data.aws_subnet.my_subnet_list[0].id, data.aws_subnet.my_subnet_list[1].id]
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
  db_subnet_group_name  = aws_db_subnet_group.my_subnet_group.id
  # vpc_security_group_ids = [aws_security_group.db.id]
}


