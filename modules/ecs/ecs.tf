# Using data source fetching subnet that has custom tag in your VPC
data "aws_subnet" "ecs_subnet" {
    count             = 2
    availability_zone = "eu-west-1${element(["a", "b"], count.index)}"
    tags              = {
      sidg            = "public_Subnet"
    }
}

data "aws_security_group" "ecs_sg" {
      tags              = {
      Name            = "EC2_SECURITY_GROUP"
    }
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
  container_definitions    = jsonencode([{
    "name": "nginx",
    "image": "nginx:latest",  # Use the latest version of nginx image
    "cpu": 256,               # Adjust as needed
    "memory": 512,            # Adjust as needed
    "essential": true
  }])

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }
}

resource "aws_ecs_service" "my_service" {
  name            = "demo-ecs-service"
  cluster         = aws_ecs_cluster.demo_ecs.id
  task_definition = aws_ecs_task_definition.demo_task_def.arn
  launch_type     = "FARGATE"
  desired_count   = 2

  network_configuration {
    subnets = [data.aws_subnet.ecs_subnet[0].id, data.aws_subnet.ecs_subnet[1].id]
    assign_public_ip = true
    security_groups = [data.aws_security_group.ecs_sg.id]
  }

  lifecycle {
    ignore_changes = [desired_count]
  }
}