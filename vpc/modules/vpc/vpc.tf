## vpc.tf
resource "aws_vpc" "vpc" {
  cidr_block           = var.cidr_block
  tags = {
    Name = "${var.env}_vpc"
    Env  = var.env
  }
}

resource "aws_subnet" "subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.subnet
  map_public_ip_on_launch = "true"
tags = {
    #Name = "${var.env}_subnet"
    Name = "test_subnet"
    Env  = var.env
  }
}

output "subnet_id" {
   value = aws_subnet.subnet.id
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id
tags = {
    Name = "${var.env}_gw"
    Env  = var.env
  }
}

resource "aws_default_route_table" "route_table" {
  default_route_table_id = aws_vpc.vpc.default_route_table_id
route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
tags = {
    Name = "default route table"
    env  = var.env
  }
}

resource "aws_default_security_group" "sg-001233" {
  vpc_id = aws_vpc.vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
     from_port   = 443
     to_port     = 443
     protocol    = "tcp"
     cidr_blocks = ["10.10.0.1/32"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "webserver-rules" {
   value = [aws_default_security_group.sg-001233.id]
}