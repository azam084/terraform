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

variable "mydb_name" {
    type = string
    default = ""
}
variable "mydb_ic" {
        type = string
        default = ""
}

variable "rds_instance_count" {
    type = set(string)
    default = []

}

#variable "vpc_id" {}
variable "allocated_storage" {
    type = number
    default = "10"

}

variable "db_engine" {}
variable "db_engine_version" {}