variable "db_subnet_name" {
  type = list(string)
}


variable "db_instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t3.medium"  
}

variable "db_allocated_storage" {
  description = "Allocated storage for the RDS instance in GB"
  type        = number
  default     = 20
}

variable "db_engine" {
  description = "Database engine for RDS"
  type        = string
  default     = "mysql"
}

variable "db_engine_version" {
  description = "Database engine version"
  type        = string
  default     = "8.0"
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