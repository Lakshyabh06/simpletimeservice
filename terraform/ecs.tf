# ECS Cluster
resource "aws_ecs_cluster" "my_cluster" {
    name = "simpletimeservice-cluster"

    tags = {
        Name = "simpletimeservice-cluster"
    }
}
