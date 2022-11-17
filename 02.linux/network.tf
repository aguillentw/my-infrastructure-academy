resource "aws_vpc" "abel_linux_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "abel-linux-vpc"
  }
}

resource "aws_subnet" "abel_private_subnet_1a" {
  vpc_id            = aws_vpc.abel_linux_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "eu-west-1a"

  tags = {
    Name = "abel-private-1a"
  }
}

#resource "aws_subnet" "abel_private_subnet_1b" {
#  vpc_id            = aws_vpc.abel_linux_vpc.id
#  cidr_block        = "10.0.2.0/24"
#  availability_zone = "eu-west-1b"
#
#  tags = {
#    Name = "abel-private-1b"
#  }
#}

resource "aws_internet_gateway" "abel_igw" {
  vpc_id = aws_vpc.abel_linux_vpc.id

  tags = {
    Name = "abel_vpc-igw"
  }
}

resource "aws_route" "abel_route" {
  route_table_id         = aws_vpc.abel_linux_vpc.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.abel_igw.id
}