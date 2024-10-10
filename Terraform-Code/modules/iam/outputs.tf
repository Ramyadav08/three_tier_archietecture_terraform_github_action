output "iam_instance_profile" {
  value = aws_iam_role.ec2_role.id
}