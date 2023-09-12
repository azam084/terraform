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

data "aws_lb_target_group" "demo_ecs_target_group" {
    tags      = {
    name    = "ecs-alb-target-group"
  }
  }


resource "aws_ecs_cluster" "demo_ecs" {
  name = var.ecs_cluster_name

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
    tags = {
    name = "demo-ecs-cluster"
  }
}

resource "aws_ecs_task_definition" "demo_task_def" {
  family                   = "demo_ecs"
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
          "portMappings": [
            {
              "containerPort": 80,
              }
          ]
  }])

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }
}

resource "aws_ecs_service" "my_service" {
  name            = var.ecs_service_name
  cluster         = aws_ecs_cluster.demo_ecs.id
  task_definition = aws_ecs_task_definition.demo_task_def.arn
  launch_type     = "FARGATE"
  desired_count   = 2

  network_configuration {
    subnets = [data.aws_subnet.ecs_subnet[0].id, data.aws_subnet.ecs_subnet[1].id]
    assign_public_ip = true
    security_groups = [data.aws_security_group.ecs_sg.id]
  }

  load_balancer {
    target_group_arn = data.aws_lb_target_group.demo_ecs_target_group.arn
    container_name   = "nginx"
    container_port   = 80
  }

  lifecycle {
    ignore_changes = [desired_count]
  }

  tags = {
    name = "demo-ecs-service"
  }
}

# resource "aws_cloudwatch_metric_alarm" "ecs_cpu_alarm" {
#   alarm_name          = "ecs-cpu-scaling-alarm"
#   comparison_operator = "GreaterThanOrEqualToThreshold"
#   evaluation_periods = 2
#   metric_name        = "CPUUtilization"
#   namespace          = "AWS/ECS"
#   period             = 60
#   statistic          = "Maximum"
#   threshold           = 1 # Adjust this threshold as needed
#   alarm_description  = "Scale ECS service up based on CPU"
#   #alarm_actions      = [aws_autoscaling_policy.ecs_scaling_policy.arn]
#   dimensions = {
#     ServiceName = aws_ecs_service.my_service.name
#   }
# }

resource "aws_appautoscaling_target" "ecs_target" {
  max_capacity       = 4
  min_capacity       = 1
  resource_id        = "service/${var.ecs_cluster_name}/${var.ecs_service_name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

resource "aws_appautoscaling_policy" "dev_to_cpu" {
  name = "dev-to-cpu"
  policy_type = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.ecs_target.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs_target.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }

    target_value = 1
  }
}

resource "aws_appautoscaling_policy" "dev_to_memory" {
  name               = "dev-to-memory"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.ecs_target.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs_target.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageMemoryUtilization"
    }

    target_value       = 80
  }
}