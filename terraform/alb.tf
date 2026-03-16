# Load Balancer (Application)
resource "aws_lb" "app_lb" {
    name = "simpletimeservice-alb"
    internal = false
    load_balancer_type = "application"

    subnets = data.aws_subnets.default.ids
    security_groups = [
        aws_security_group.my_sg.id
    ]
}

# Target Group
resource "aws_lb_target_group" "ecs_tg" {
    name = "simpletimeservice-tg"
    port = 8080
    protocol = "HTTP"
    target_type = "ip"
    vpc_id = aws_default_vpc.default.id

    health_check {
        path = "/"
        port = "8080"
    }
}

# Listener
resource "aws_lb_listener" "http" {
    load_balancer_arn = aws_lb.app_lb.arn
    port = 80
    protocol = "HTTP"

    default_action {
      type = "redirect"
      
      redirect {
        port = "443"
        protocol = "HTTPS"
        status_code = "HTTP_301"
      }
    }
}

resource "aws_lb_listener" "https" {
    load_balancer_arn = aws_lb.app_lb.arn
    port = 443
    protocol = "HTTPS"
    ssl_policy = "ELBSecurityPolicy-2016-08"

    certificate_arn = aws_acm_certificate.ecs_cert.arn

    default_action {
      type = "forward"
      target_group_arn = aws_lb_target_group.ecs_tg.arn
    }  
}