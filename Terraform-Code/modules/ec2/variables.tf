variable "ami_id" {
  description = "AMI ID to use for the test EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "app_tier_subnet_id" {
  description = "Subnet ID where the test EC2 instance will be launched"
  type        = string
  default = app_tier_subnet_id.appsubnets[0]
}

variable "iam_instance_profile" {
  description = "IAM instance profile name for EC2 to allow SSM and S3 access"
  type        = string
}

variable "app_tier_sg_id" {
  type = string
}

variable "aws_s3_bucket" {
  type = string
}