variable "region" {}
variable "project_name" {}
variable "vpc_cidr" {}
variable "public_subnet_az1_cidr" {}
variable "public_subnet_az2_cidr" {}
variable "private_app_subnet_az1_cidr" {}
variable "private_app_subnet_az2_cidr" {}
variable "private_data_subnet_az1_cidr" {}
variable "private_data_subnet_az2_cidr" {}

variable "ingress_cidr_blocks" {}
variable "egress_cidr_blocks" {}
variable "sg_name" {}


# Below variable are for RDS


# variable "allocated_storage" {
#     type = number
#     default = "10"

# }

# variable "mydb_name" {
#     type = string
#     default = ""
# }

variable "db_engine" {
    type = string
    default = "mysql"
}

variable "db_engine_version" {
    type = number
    default = "5.7"
}

# variable "mydb_ic" {
#         type = string
#         default = ""
# }

