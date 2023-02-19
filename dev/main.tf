# Configure Provider

provider "aws" {
  region = var.region
  profile = "DanatTest"
}

# Creating VPC

module "vpc" {
    source                          = "../modules/vpc"
    region                          = var.region
    project_name                    = var.project_name
    vpc_cidr                        = var.vpc_cidr
    public_subnet_az1_cidr          = var.public_subnet_az1_cidr
    public_subnet_az2_cidr          = var.public_subnet_az2_cidr
    private_app_subnet_az1_cidr     = var.private_app_subnet_az1_cidr
    private_app_subnet_az2_cidr     = var.private_app_subnet_az2_cidr
    private_data_subnet_az1_cidr    = var.private_data_subnet_az1_cidr
    private_data_subnet_az2_cidr    = var.private_data_subnet_az2_cidr
    sg_name = "EC2_SG"
    egress_cidr_blocks = "0.0.0.0/0"
    ingress_cidr_blocks = "0.0.0.0/0"
}   



#module "security_groups" {
#     source                          = "../modules/security_groups"
#     ingress_cidr_blocks             = var.ingress_cidr_blocks
#     egress_cidr_blocks              = var.egress_cidr_blocks
#     sg_name                         = var.sg_name
#     #vpc_id                          = var.vpc_id
# }