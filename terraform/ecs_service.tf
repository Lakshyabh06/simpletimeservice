# Subnets (Default)
data "aws_subnets" "default" {
    filter {
      name = "default-for-az"
      values = ["true"]
    }
}

# ECS Service
resource "aws_ecs_service" "app_service" {
    name = "simpletimeservice-service"
    cluster = aws_ecs_cluster.my_cluster.arn
    task_definition = aws_ecs_task_definition.aws_task.arn
    desired_count = 1
    launch_type = "FARGATE"

    load_balancer {
      target_group_arn = aws_lb_target_group.ecs_tg.arn
      container_name = "simpletimeservice"
      container_port = 8080
    }

    network_configuration {

      subnets = data.aws_subnets.default.ids

      security_groups = [
        aws_security_group.my_sg.id
      ]

      assign_public_ip = true
    }
}