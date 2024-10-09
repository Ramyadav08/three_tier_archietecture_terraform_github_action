# External Load Balancer Security Group
resource "aws_security_group" "external_load_balancer" {
  name        = "External_loadbalancer"
  description = "Allow HTTP traffic from anywhere"
  vpc_id     = var.vpc_id  # Ensure to pass the VPC ID as a variable

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Web Tier Security Group
resource "aws_security_group" "web_tier_sg" {
  name        = "Web_tier_sg"
  description = "Allow HTTP traffic from External Load Balancer"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [aws_security_group.external_load_balancer.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Internal Load Balancer Security Group
resource "aws_security_group" "internal_load_balancer" {
  name        = "Internal_loadbalancer"
  description = "Allow HTTP traffic from Web Tier"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [aws_security_group.web_tier_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# App Tier Security Group
resource "aws_security_group" "app_tier_sg" {
  name        = "App_tier_sg"
  description = "Allow traffic on port 4000 from Internal Load Balancer"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 4000
    to_port     = 4000
    protocol    = "tcp"
    security_groups = [aws_security_group.internal_load_balancer.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Database Tier Security Group
resource "aws_security_group" "db_tier_sg" {
  name        = "Db_tier_sg"
  description = "Allow traffic on port 3306 from App Tier"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_groups = [aws_security_group.app_tier_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}