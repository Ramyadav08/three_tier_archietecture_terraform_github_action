variable "vpc_cidr" {
    description = "vpc cidr range"
    type = string
}

variable "web_subnet_cidr" {
    description = "subnet cidr ranges "
    type = list(string)
  
}

variable "app_subnet_cidr" {
    description = "subnet cidr ranges "
    type = list(string)
  
}

variable "db_subnet_cidr" {
    description = "subnet cidr ranges "
    type = list(string)
  
}

variable "web_subnet_name" {
    description = "subnet names"
    type = list(string)
    default = [ "web_pub_01","web_pub_02" ]
  
}

variable "app_subnet_name" {
    description = "subnet names"
    type = list(string)
    default = [ "app_pri_01","app_pri_02" ]
  
}

variable "db_subnet_name" {
    description = "subnet names"
    type = list(string)
    default = [ "db_pri_01","db_pri_02" ]
  
}

