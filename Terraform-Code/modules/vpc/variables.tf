variable "vpc_cidr" {
    description = "vpc cidr range"
    type = string
}

variable "web_subnet_cidr" {
    description = "subnet cidr ranges "
    type = list(string)
  
}

variable "web_subnet_name" {
    description = "subnet names"
    type = list(string)
    default = [ "web_pub_01","web_pub_02" ]
  
}