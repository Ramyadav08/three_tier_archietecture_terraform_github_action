variable "vpc_cidr" {
  description = "vpc cidr range"
  type        = string
}

variable "web_subnet_cidr" {
  description = "subnet cidr ranges "
  type        = list(string)

}
