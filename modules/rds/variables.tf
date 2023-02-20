variable "mydb_name" {
    type = string
    default = ""
}
variable "mydb_ic" {
        type = string
        default = ""
}
# variable "vpc_security_group_ids" {
#          type = set(string)
#          default = []
# }
variable "rds_instance_count" {
    type = set(string)
    default = []

}

variable "vpc_id" {}