
data "aws_vpc" "selected" {
 id = module.vpc.aws_vpc.vpc.id
}

# create a DB subnet group
resource "aws_db_subnet_group" "vpc_subnet_id_group" {
  depends_on = [data.aws_vpc.selected.id]
  #subnet_ids               = ["${module.vpc.private_data_subnet_az1.id}"]
  subnet_ids              = ["private_data_subnet_az1_id", "private_data_subnet_az2_id"]

  tags = {
    Name    = "${var.project_name}-SUBNET-GID"
  }
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
  db_subnet_group_name  = aws_db_subnet_group.vpc_subnet_id_group.name
}