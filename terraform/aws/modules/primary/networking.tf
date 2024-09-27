resource "aws_vpc" "primary_task_vpc" {
  cidr_block = "10.0.0.0/21"
  tags = {
    Name = "primary-task-vpc"
  }
}

resource "aws_subnet" "primary_task_vpc_subnet" {
  vpc_id     = aws_vpc.primary_task_vpc.id
  cidr_block = "10.0.1.0/24"
  
  tags = {
    Name = "primary-task-vpc-subnet"
  }
}

resource "aws_internet_gateway" "primary_task_vpc_igw" {
  vpc_id = aws_vpc.primary_task_vpc.id

  tags = {
    Name = "primary-task-vpc-igw"
  }
}

resource "aws_route_table" "primary_task_vpc_rt" {
  vpc_id = aws_vpc.primary_task_vpc.id

  tags = {
    Name = "primary-task-vpc-rt"
  }
}

resource "aws_route_table_association" "primary_task_vpc_rt_association" {
  subnet_id = aws_subnet.primary_task_vpc_subnet.id
  route_table_id = aws_route_table.primary_task_vpc_rt.id
}

resource "aws_route" "primary_task_vpc_public_subnet_internet_route" {
  destination_cidr_block = "0.0.0.0/0"
  route_table_id = aws_route_table.primary_task_vpc_rt.id
  gateway_id = aws_internet_gateway.primary_task_vpc_igw.id
}