resource "aws_vpc" "vpc" {
  cidr_block           = var.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "publishing-platform-${var.publishing_platform_environment}"
  }
}

resource "aws_internet_gateway" "public" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "publishing-platform-${var.publishing_platform_environment}"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.public.id
  }

  tags = {
    Name = "publishing-platform-${var.publishing_platform_environment}"
  }
}