
# Using data source fetching subnet that has custom tag in your VPC
data "aws_subnet" "my_subnet_list" {
    count             = 2
    availability_zone = "eu-west-1${element(["a", "b"], count.index)}"
    tags              = {sidg = "public_Subnet"}
}

# Create subnet group in RDS
resource "aws_db_subnet_group" "my_subnet_group"{
    name              = "my-subnet-group"
    description       = "My subnet group"
    subnet_ids        = [data.aws_subnet.my_subnet_list[0].id, data.aws_subnet.my_subnet_list[1].id]
}

data "aws_security_group" "rds_sg" {
      tags            = {
      Name            = "EC2_SECURITY_GROUP"
    }
}

# create RDS 
resource "aws_db_instance" "myrds" {
  allocated_storage     = var.allocated_storage
  db_name               = var.mydb_name
  engine                = var.db_engine
  engine_version        = var.db_engine_version
  instance_class        = var.instance_class
  username              = var.username
  password              = var.password
  skip_final_snapshot   = true
  identifier            = "dev-demo-rds"
  db_subnet_group_name  = aws_db_subnet_group.my_subnet_group.id
  vpc_security_group_ids = [data.aws_security_group.rds_sg.id]
  publicly_accessible   = true
  tags                  = {name = "RDS-DB"}
}


