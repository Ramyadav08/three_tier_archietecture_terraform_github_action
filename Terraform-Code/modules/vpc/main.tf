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
  map_public_ip_on_launch = true
  tags = {
    Name = var.web_subnet_name[count.index]
  }
}

#internetgateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "MyInternetGateWay"
  }
}

#routetable
resource "aws_route_table" "web_rt" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"   
    gateway_id = aws_internet_gateway.igw.id

  }

}

#routtable associate
resource "aws_route_table_association" "web_rt_asso" {
  count = length(var.web_subnet_cidr)
  subnet_id      = aws_subnet.subnets[count.index]
  route_table_id = aws_route_table.web_rt.id
}
