region                       = "eu-west-1"
project_name                 = "DEV_ENV"
vpc_cidr                     = "10.0.0.0/16"
public_subnet_az1_cidr       = "10.0.0.0/24"
public_subnet_az2_cidr       = "10.0.1.0/24"
private_app_subnet_az1_cidr  = "10.0.2.0/24"
private_app_subnet_az2_cidr  = "10.0.3.0/24"
private_data_subnet_az1_cidr = "10.0.4.0/24"
private_data_subnet_az2_cidr = "10.0.5.0/24"


ingress_cidr_blocks = "0.0.0.0/0"
egress_cidr_blocks  = "0.0.0.0/0"
sg_name             = "EC2_SECURITY_GROUP"


# RDS Values

db_engine         = "mysql"
db_engine_version = "5.7"