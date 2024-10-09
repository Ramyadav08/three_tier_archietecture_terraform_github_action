output "vpc_id" {
    value = aws_vpc.my_vpc.id
    
}
output "db_subnet_name" {
    value = aws_subnet.dbsubnets[*].id
}