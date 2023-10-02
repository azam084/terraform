# Configure Provider

provider "aws" {
  region  = var.region
  profile = "DanatTest"
}

terraform {
  backend "s3" {
    bucket          = "terrastate.danat"
    key             = "dev/terraform.tfstate"
    region          = "eu-west-1"
    dynamodb_table  = "terraform_state"
    profile         = "DanatTest"
  }
}

# Creating VPC

module "vpc" {
  source                       = "../../modules/vpc"
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
}


/* module "rds" {
  depends_on                  = [module.vpc]
  source                      = "../../modules/rds"
  allocated_storage           = var.allocated_storage
  mydb_name                   = var.mydb_name
  db_engine                   = var.db_engine
  db_engine_version           = var.db_engine_version
  instance_class              = var.instance_class
  username                    = var.username
  password                    = var.password
}

module "ecs" {
  depends_on                  = [module.vpc, module.rds]
  source                      = "../../modules/ecs"
}   */
