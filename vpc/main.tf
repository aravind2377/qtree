provider "aws" {
  region = "ap-south-1"
  access_key="AKIAW6JOTZGV4R7KND2Y"
  secret_key="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"
  
}

resource  "aws_vpc" "prod" {
    cidr_block  = "10.0.0.0/16"
    tags = {
    Name = "project"
    }
  
}

resource "aws_subnet" "prod-public" {
     vpc_id     = aws_vpc.prod.id
     cidr_block             = "10.0.0.0/24"
     availability_zone = "ap-south-1"


tags = {
    Name = "project-Public-Subnet"
  }
 
}

resource "aws_subnet" "prod-private" {
     vpc_id     = aws_vpc.prod.id
     cidr_block             = "10.0.1.0/24"
     availability_zone = "ap-south-1"


tags = {
    Name = "project-Private-Subnet"
  }
 
}

resource "aws_internet_gateway" "igw" {
  vpc_id   = aws_vpc.prod.id
  tags = {
    Name = "project-igw"
  }
}

resource "aws_eip" "project_nat_eip" {
  domain   = "vpc"
  tags = {
      Name = "project_nat_eip"
  }
}

resource "aws_nat_gateway" "project_natgateway"{
   allocation_id= aws_eip.project_nat_eip.id
   subnet_id = aws_subnet.prod-public.id
    tags = {
      Name = "Project Natgateway"
          }
}

resource "aws_route_table" "project-public-rt" {
  vpc_id = aws_vpc.prod.id
      tags = {
      Name = "Project public routetable"
          }
}

resource "aws_route_table" "project-private-rt" {
  vpc_id = aws_vpc.prod.id
      tags = {
      Name = "Project-private-routetable"
          }
}
resource "aws_route_table_association" "project-public-routetable"{



