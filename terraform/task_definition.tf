resource "aws_ecs_task_definition" "aws_task" {
    family = "simpletimeservice-task"
    requires_compatibilities = ["FARGATE"]
    network_mode = "awsvpc"

    execution_role_arn = aws_iam_role.ecs_task_execution_role.arn

    cpu = "256"
    memory = "512"

    container_definitions = jsonencode([
        {
            name = "simpletimeservice"
            image = "lakshya0612/simpletimeservice:latest"

            portMappings = [
                {
                    containerPort = 8080
                    hostPort = 8080
                    protocol = "tcp"
                }
            ]

            logConfiguration = {
                logDriver = "awslogs"
                options = {
                    awslogs-group = "/ecs/simpletimeservice"
                    awslogs-region = "us-east-1"
                    awslogs-stream-prefix = "ecs"
                }
            }
        }
    ])
}