module "vpc" {
  source = "./modules/vpc"
  vpc_cidr = var.vpc_cidr
  web_subnet_cidr = var.web_subnet_cidr
  app_subnet_cidr = var.app_subnet_cidr
  db_subnet_cidr = var.db_subnet_cidr
}

module "s3" {
  source = "./modules/s3"
}

module "aws_iam_role" {
  source = "./modules/iam"
  bucket_name = module.s3.bucket_ids
  bucket_arn =  module.s3.bucket_arns
  
}

module "security_groups" {
  source = "./modules/sg"
  vpc_id = module.vpc.vpc_id
  
}

module "rds" {
  source = "./modules/rds"
  db_username = var.db_username
  db_password = var.db_password
  db_tier_sg_id = module.security_groups.db_tier_sg_id
  db_subnet_name = module.vpc.db_subnet_name
  
}