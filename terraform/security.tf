# VPC & Security Group
resource "aws_default_vpc" "default" {
  
}

resource "aws_security_group" "my_sg" {
    name = "terra-sg"
    description = "This add terraform automated security group"
    vpc_id = aws_default_vpc.default.id

    tags = {
      Name = "simpletimeservice-sg"
    }

    # Inbound Rules
    ingress {
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "app access"
    }

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "HTTP open"
    }

    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "HTTPS open"
    }

    # Outbound Rules
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        description = "open outbound access"
    }
}