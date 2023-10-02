variable "allocated_storage" {
    type        = number
    default     = "10"

}

variable "mydb_name" {
    type        = string
    default     = ""
}

variable "db_engine" {
    type        = string
    default     = "mysql"
}

variable "db_engine_version" {
    type        = number
    default     = "5.7"
}

# variable "subnet_ids" {
#         type = list
#         default = []
# }

variable "instance_class" {
    type        = string
    default     = "db.t3.micro"
}

variable "username" {
    type        = string
    default     = "foo"
}

variable "password" {
    type        = string
    default     = "foobarbaz"
}
