data "aws_availability_zones" "available" {}
resource "aws_vpc" "secondary_task_vpc" {
  cidr_block = "10.10.0.0/21"
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

resource "aws_internet_gateway" "secondary_task_vpc_igw" {
  vpc_id = aws_vpc.secondary_task_vpc.id

  tags = {
    Name = "secondary-task-vpc-igw"
  }
}

resource "aws_route_table" "secondary_task_vpc_rt" {
  vpc_id = aws_vpc.secondary_task_vpc.id

  tags = {
    Name = "secondary-task-vpc-rt"
  }
}

resource "aws_route_table_association" "secondary_task_vpc_rt_association" {
  subnet_id = aws_subnet.secondary_task_vpc_subnet.id
  route_table_id = aws_route_table.secondary_task_vpc_rt.id
}

resource "aws_route" "secondary_task_vpc_public_subnet_internet_route" {
  destination_cidr_block = "0.0.0.0/0"
  route_table_id = aws_route_table.secondary_task_vpc_rt.id
  gateway_id = aws_internet_gateway.secondary_task_vpc_igw.id
}