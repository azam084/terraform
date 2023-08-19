# Using data source fetching subnet that has custom tag in your VPC
data "aws_subnet" "my_subnet_listecs" {
    count             = 2
    availability_zone = "eu-west-1${element(["a", "b"], count.index)}"
}

resource "aws_ecs_cluster" "demo_ecs" {
  name = "azam-ecs"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_ecs_task_definition" "demo_task_def" {
  family                   = "demo"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 1024
  memory                   = 2048
  container_definitions    = <<TASK_DEFINITION
[
  {
    "name": "iis",
    "image": "mcr.microsoft.com/windows/servercore/iis",
    "cpu": 1024,
    "memory": 2048,
    "essential": true
  }
]
TASK_DEFINITION

  runtime_platform {
    operating_system_family = "WINDOWS_SERVER_2019_CORE"
    cpu_architecture        = "X86_64"
  }
}

resource "aws_ecs_service" "my_service" {
  name            = "demo-ecs-service"
  cluster         = aws_ecs_cluster.demo_ecs.id
  task_definition = aws_ecs_task_definition.demo_task_def.arn
  launch_type     = "FARGATE"

  network_configuration {
    subnets = [data.aws_subnet.my_subnet_listecs[0].id, data.aws_subnet.my_subnet_listecs[1].id]
    #security_groups = [aws_security_group.ecs_security_group.id]
  }
}