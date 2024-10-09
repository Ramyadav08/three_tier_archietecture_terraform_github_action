output "rds_subnet_group_id" {
  value = aws_db_subnet_group.rds_subnet_group.id
}

output "rds_endpoint" {
  description = "The endpoint address of the RDS instance"
  value       = aws_db_instance.my_rds_instance.endpoint
}

output "rds_instance_id" {
  description = "The ID of the RDS instance"
  value       = aws_db_instance.my_rds_instance.id
}
