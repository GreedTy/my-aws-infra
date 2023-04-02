resource "aws_subnet" "default-2b" {
  vpc_id = var.vpc_id
  availability_zone = "ap-northeast-2b"
  map_public_ip_on_launch = true
  cidr_block = "172.31.10.0/28"
  tags = {
    Name = "micro-public-subnet-b"
  }
}

resource "aws_subnet" "default-2d" {
  vpc_id = var.vpc_id
  availability_zone = "ap-northeast-2d"
  map_public_ip_on_launch = true
  cidr_block = "172.31.20.0/28"
  tags = {
    Name = "micro-public-subnet-d"
  }
}

resource "aws_subnet" "default-2a" {
  vpc_id = var.vpc_id
  availability_zone = "ap-northeast-2a"
  map_public_ip_on_launch = false
  cidr_block = "172.31.30.0/28"
  tags = {
    Name = "micro-private-subnet-a"
  }
}

resource "aws_subnet" "default-2c" {
  vpc_id = var.vpc_id
  availability_zone = "ap-northeast-2c"
  map_public_ip_on_launch = false
  cidr_block = "172.31.40.0/28"
  tags = {
    Name = "micro-private-subnet-c"
  }
}