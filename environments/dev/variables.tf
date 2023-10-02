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


variable "allocated_storage" {
    type = number
    default = "10"

}

variable "mydb_name" {
    type = string
    default = ""
}

variable "db_engine" {
    type = string
    default = "mysql"
}

variable "db_engine_version" {
    type = number
    default = "5.7"
}

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


# Below variable are for ECS

/* variable "ecs_cluster_name" {
  description = "dev-ecs"
  default = "dev-ecs"
}

variable "ecs_service_name" {
  description = "demo-ecs-service"
  default = "demo-ecs-service"
}

variable "task_count" {
    type = number
    default = "2"
}

variable "container_cpu" {
    type = number
    default = "256"
}

variable "container_memory" {
    type = number
    default = "512"
}

variable "container_image" {
    type = string
    default = "myazam084/my-flask-app:latest"
} */