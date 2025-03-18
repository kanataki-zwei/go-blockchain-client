resource "aws_ecs_task_definition" "blockchain_task" {
  family                   = "blockchain-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.ecs_task_cpu
  memory                   = var.ecs_task_memory
  execution_role_arn       = aws_iam_role.ecs_task_role.arn

  container_definitions = jsonencode([
    {
      name      = "blockchain-client"
      image     = var.docker_image_url
      cpu       = var.ecs_task_cpu
      memory    = var.ecs_task_memory
      essential = true
      portMappings = [{
        containerPort = var.container_port
        hostPort      = var.container_port
      }]
    }
  ])
}

resource "aws_ecs_cluster" "blockchain_cluster" {
  name = var.ecs_cluster_name
}

resource "aws_ecs_service" "blockchain_service" {
  name            = var.ecs_service_name
  cluster         = aws_ecs_cluster.blockchain_cluster.id
  task_definition = aws_ecs_task_definition.blockchain_task.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = [aws_subnet.blockchain_subnet.id]
    security_groups  = [aws_security_group.blockchain_sg.id]
    assign_public_ip = true
  }
}
