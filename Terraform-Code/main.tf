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