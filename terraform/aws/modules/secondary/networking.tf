data "aws_availability_zones" "available" {}
resource "aws_vpc" "secondary_task_vpc" {
  cidr_block = var.secondary_task_vpc_cidr
  enable_dns_hostnames = true
  tags = {
    Name = "secondary-task-vpc"
  }
}

resource "aws_subnet" "secondary_task_vpc_subnet" {
  vpc_id     = aws_vpc.secondary_task_vpc.id
  cidr_block = "10.10.1.0/24"
  availability_zone = data.aws_availability_zones.available.names[0]
  tags = {
    Name = "secondary-task-vpc-subnet1"
  }
}

resource "aws_subnet" "secondary_task_vpc_private_subnet_1" {
  vpc_id     = aws_vpc.secondary_task_vpc.id
  cidr_block = "10.10.3.0/24"
  availability_zone = data.aws_availability_zones.available.names[0]
  tags = {
    Name = "secondary-task-vpc-private-subnet-1"
  }
}

resource "aws_subnet" "secondary_task_vpc_private_subnet_2" {
  vpc_id     = aws_vpc.secondary_task_vpc.id
  cidr_block = "10.10.6.0/24"
  availability_zone = data.aws_availability_zones.available.names[1]
  tags = {
    Name = "secondary-task-vpc-private-subnet-2"
  }
}

resource "aws_internet_gateway" "secondary_task_vpc_igw" {
  vpc_id = aws_vpc.secondary_task_vpc.id

  tags = {
    Name = "secondary-task-vpc-igw"
  }
}

resource "aws_route_table" "secondary_task_vpc_rt" {
  vpc_id = aws_vpc.secondary_task_vpc.id

  route {
    cidr_block = var.secondary_task_vpc_cidr
    gateway_id = "local"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.secondary_task_vpc_igw.id
  }

  tags = {
    Name = "secondary-task-vpc-rt"
  }
}

resource "aws_route_table_association" "secondary_task_vpc_rt_association" {
  subnet_id = aws_subnet.secondary_task_vpc_subnet.id
  route_table_id = aws_route_table.secondary_task_vpc_rt.id
}

resource "aws_route_table_association" "secondary_task_vpc_psn1_rt_association" {
  subnet_id = aws_subnet.secondary_task_vpc_private_subnet_1.id
  route_table_id = aws_route_table.secondary_task_vpc_rt.id
}
resource "aws_route_table_association" "secondary_task_vpc_psn2_rt_association" {
  subnet_id = aws_subnet.secondary_task_vpc_private_subnet_2.id
  route_table_id = aws_route_table.secondary_task_vpc_rt.id
}