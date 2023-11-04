# VPC
resource "aws_vpc" "main" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = true
  tags = {
    Name = var.name
  }
}

# Internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.name}-igw"
  }
}

# NAT gateway
resource "aws_eip" "nat" {
  depends_on = [aws_internet_gateway.igw]

  tags = {
    Name = "${var.name}-eip"
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_ap-south_1a.id

  tags = {
    Name = "${var.name}-nat-gateway"
  }
}

# Private subnet
resource "aws_subnet" "private_ap-south_1a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.0.0/19"
  availability_zone = "ap-south-1a"

  tags = {
    "Name"                            = "private-ap-south-1a"
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/demo"      = "owned"
  }
}

resource "aws_subnet" "private_ap-south_1b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.32.0/19"
  availability_zone = "ap-south-1b"

  tags = {
    "Name"                            = "private-ap-south-1b"
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/demo"      = "owned"
  }
}

# Public subnet
resource "aws_subnet" "public_ap-south_1a" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.64.0/19"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true

  tags = {
    "Name"                       = "public-ap-south-1a"
    "kubernetes.io/role/elb"     = "1"
    "kubernetes.io/cluster/demo" = "owned"
  }
}

resource "aws_subnet" "public_ap-south_1b" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.96.0/19"
  availability_zone       = "ap-south-1b"
  map_public_ip_on_launch = true

  tags = {
    "Name"                       = "public-ap-south-1b"
    "kubernetes.io/role/elb"     = "1"
    "kubernetes.io/cluster/demo" = "owned"
  }
}

# Route Tables
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "private"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public"
  }
}

resource "aws_route_table_association" "private_ap-south_1a" {
  subnet_id      = aws_subnet.private_ap-south_1a.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_ap-south_1b" {
  subnet_id      = aws_subnet.private_ap-south_1b.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "public_ap-south_1a" {
  subnet_id      = aws_subnet.public_ap-south_1a.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_ap-south_1b" {
  subnet_id      = aws_subnet.public_ap-south_1b.id
  route_table_id = aws_route_table.public.id
}

resource "aws_security_group" "example" {
  name_prefix = "demo"

  # Ingress rules
  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  # Egress rules
  dynamic "egress" {
    for_each = var.egress_rules
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }

}




