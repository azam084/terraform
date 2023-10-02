variable "ecs_cluster_name" {
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
