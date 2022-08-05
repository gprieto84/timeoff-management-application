
resource "aws_ecs_cluster" "timeoff_cluster" {
  name = "timeoff-cluster-${var.env}"
}

resource "aws_ecs_task_definition" "timeoff_task" {
  family                   = "timeoff-task"
  container_definitions    = <<DEFINITION
  [
    {
      "name": "timeoff-task",
      "image": "${aws_ecr_repository.timeoff_ecr_repo.repository_url}",
      "essential": true,
      "portMappings": [
        {
          "containerPort": 3000,
          "hostPort": 3000
        }
      ],
      "memory": 512,
      "cpu": 256
    }
  ]
  DEFINITION
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  memory                   = 512
  cpu                      = 256
  execution_role_arn       = aws_iam_role.ecsTaskExecutionRole.arn
}

resource "aws_ecs_service" "timeoff_service" {
  name            = "timeoff-service-${var.env}"
  cluster         = aws_ecs_cluster.timeoff_cluster.id
  task_definition = aws_ecs_task_definition.timeoff_task.arn
  launch_type     = "FARGATE"
  desired_count   = 3

  load_balancer {
    target_group_arn = aws_lb_target_group.target_group.arn
    container_name   = aws_ecs_task_definition.timeoff_task.family
    container_port   = 3000
  }

  network_configuration {
    subnets          = ["${aws_default_subnet.default_subnet_a.id}", "${aws_default_subnet.default_subnet_b.id}", "${aws_default_subnet.default_subnet_c.id}"]
    security_groups  = ["${aws_security_group.timeoff_service_security_group.id}"]
    assign_public_ip = true
  }
}
