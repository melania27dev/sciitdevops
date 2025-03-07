resource "aws_vpc" "melania-vpc" {
  cidr_block = var.vpc_cidr
  tags       = merge(local.common_tags, { Name = "melania-vpc" })
}

resource "aws_subnet" "public-subnet" {
  vpc_id                  = aws_vpc.melania-vpc.id
  cidr_block              = var.public_subnet_cidr
  map_public_ip_on_launch = true
  availability_zone       = var.public_subnet_az
  tags                    = merge(local.common_tags, { Name = "public-subnet" })
}

resource "aws_subnet" "private-subnet" {
  vpc_id            = aws_vpc.melania-vpc.id
  cidr_block        = var.private_subnet_cidr
  availability_zone = var.private_subnet_az
  tags              = merge(local.common_tags, { Name = "private-subnet" })
}

resource "aws_internet_gateway" "net-igw" {
  vpc_id = aws_vpc.melania-vpc.id
  tags   = merge(local.common_tags, { Name = "net-igw" })
}

resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.melania-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.net-igw.id
  }
  tags = merge(local.common_tags, { Name = "public-rt" })
}

resource "aws_route_table_association" "public-rt" {
  subnet_id      = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.public-rt.id
}
