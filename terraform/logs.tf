# Log Group (Cloudwatch)
resource "aws_cloudwatch_log_group" "ecs_logs" {
    name = "/ecs/simpletimeservice"
    retention_in_days = 7
}