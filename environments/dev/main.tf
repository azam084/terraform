# Configure Provider

provider "aws" {
  region  = var.region
  profile = "DanatTest"
}

# Creating VPC

module "vpc" {
  source                       = "../modules/vpc"
  region                       = var.region
  project_name                 = var.project_name
  vpc_cidr                     = var.vpc_cidr
  public_subnet_az1_cidr       = var.public_subnet_az1_cidr
  public_subnet_az2_cidr       = var.public_subnet_az2_cidr
  private_app_subnet_az1_cidr  = var.private_app_subnet_az1_cidr
  private_app_subnet_az2_cidr  = var.private_app_subnet_az2_cidr
  private_data_subnet_az1_cidr = var.private_data_subnet_az1_cidr
  private_data_subnet_az2_cidr = var.private_data_subnet_az2_cidr
  sg_name                      = var.sg_name
  egress_cidr_blocks           = var.egress_cidr_blocks
  ingress_cidr_blocks          = var.ingress_cidr_blocks
  #vpc_id = module.vpc.aws_vpc.vpc.id
}
module "rds" {
  source            = "../modules/rds"
  #depends_on        = [module.vpc.private_data_subnet_az1, module.vpc.private_data_subnet_az2]
  db_engine         = var.db_engine
  db_engine_version = var.db_engine_version
  allocated_storage     = var.allocated_storage
  instance_class        = var.mydb_ic
  username              = "foo"
  password              = "foobarbaz"
  skip_final_snapshot   = false
  db_subnet_group_name  = module.vpc.my_subnet_group
}
