resource "aws_acm_certificate" "ecs_cert" {
    domain_name = "simpletimeservice.techmanship.in"
    validation_method = "DNS"

    lifecycle {
      create_before_destroy = true
    }  
}