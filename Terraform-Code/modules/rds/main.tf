#subnet group

resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "my-rds-subnet-group"
  subnet_ids = var.db_subnet_name
  description = "RDS Subnet Group for database subnets"

  tags = {
    Name = "my-rds-subnet-group"
  }
}


# RDS Instance Resource with Multi-AZ
resource "aws_db_instance" "my_rds_instance" {
  
  identifier              = "my-rds-instance"
  instance_class          = var.db_instance_class
  allocated_storage       = var.db_allocated_storage
  engine                  = var.db_engine
  engine_version          = var.db_engine_version
  username                = var.db_username
  password                = var.db_password
  db_subnet_group_name    = aws_db_subnet_group.rds_subnet_group.name
  multi_az                = true  # Enable Multi-AZ deployment for high availability
  storage_type            = "gp2"
  publicly_accessible     = false  # Set to false for security; only accessible within the VPC
  vpc_security_group_ids   = [var.db_tier_sg_id]

  tags = {
    Name = "my-rds-instance"
  }
}




