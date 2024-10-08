module "vpc" {
  source = "./modules/vpc"
  vpc_cidr = var.vpc_cidr
  web_subnet_cidr = var.web_subnet_cidr
}