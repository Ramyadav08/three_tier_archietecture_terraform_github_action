#vpc
resource "aws_vpc" "my_vpc" {
    cidr_block = var.vpc_cidr
    instance_tenancy = "default"
    enable_dns_hostnames = true
    enable_dns_support = true

    tags = {
      "Name"="My_Vpc"
    }
  
}


#subnet
resource "aws_subnet" "websubnets" {
  vpc_id     = aws_vpc.my_vpc.id
  count = length(var.web_subnet_cidr)
  cidr_block = var.web_subnet_cidr[count.index]
  availability_zone = data.aws_availability_zones.available.name[count.index] 

  tags = {
    Name = var.web_subnet_name[count.index]
  }
}

#internetgateway


#routetable

#routtable associate
