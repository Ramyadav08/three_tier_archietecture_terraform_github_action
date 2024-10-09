variable "vpc_cidr" {
  description = "vpc cidr range"
  type        = string
}

variable "web_subnet_cidr" {
  description = "subnet cidr ranges "
  type        = list(string)

}

variable "app_subnet_cidr" {
  description = "subnet cidr ranges "
  type        = list(string)

}

variable "db_subnet_cidr" {
  description = "subnet cidr ranges "
  type        = list(string)

}

variable "db_username" {
  description = "Username for the RDS instance"
  type        = string
}

variable "db_password" {
  description = "Password for the RDS instance"
  type        = string
  sensitive   = true
}

variable "db_tier_sg_id" {
  description = "security group which allow app tier to reach db "
  type = string
}