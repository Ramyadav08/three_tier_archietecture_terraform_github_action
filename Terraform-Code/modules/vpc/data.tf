data "aws_availability_zones" "available" {
  state = "available"
  filter {
    name   = "Mumbai"
    values = ["ap-south-1"]
  }
}

locals {
  zones = ["ap-south-1a", "ap-south-1b"]
}
