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

variable "db_engine" {
    type = string
    default = "mysql"
}
variable "db_engine_version" {
    type = number
    default = "5.7"
}

variable "vpc_id" {
    type = string
    default = ""
}

