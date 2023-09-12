
# Create an ALB (Application Load Balancer)
resource "aws_lb" "demo_ecs_alb" {
  name               = "demo-ecs-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.ec2_sg.id]
  subnets            = [aws_subnet.public_subnet_az1.id, aws_subnet.public_subnet_az2.id] 

  tags      = {
    name    = "demo-ecs-alb"
  }
}

# Create a target group for ECS service
resource "aws_lb_target_group" "demo_ecs_alb_target-group" {
  name        = "demo-ecs-alb-target-group"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = aws_vpc.vpc.id

  depends_on = [
    aws_lb.demo_ecs_alb,
  ]

    tags      = {
    name    = "ecs-alb-target-group"
  }
}

# Create a listener for ECS service
resource "aws_lb_listener" "ecs_listener" {
  load_balancer_arn = aws_lb.demo_ecs_alb.arn
  port              = "80"
  protocol          = "HTTP"
 
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.demo_ecs_alb_target-group.arn 

  }
}
