# Tf for vpc spinup
# Controls NAT Gateway provisioning 

resource "aws_vpc" "this" {
  cidr_block           = var.cidr
  instance_tenancy     = var.inst_tenancy
  enable_dns_support   = var.dns_support
  enable_dns_hostnames = var.dns_hostn

  tags = merge({
    "Name"        = "${var.project_domain}-${var.environment}",
    "Description" = var.description,
    "Environment" = var.environment,
    "ManagedBy"   = "Terraform"
  })
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  tags = merge({
    "Name"        = "${var.project_domain}-${var.environment}",
    "Description" = var.description,
    "Environment" = var.environment,
    "ManagedBy"   = "Terraform"
  })
}

resource "aws_route_table" "this" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  route {
    ipv6_cidr_block        = "::/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = merge({
    "Name"        = "${var.project_domain}-${var.environment}",
    "Description" = var.description,
    "Environment" = var.environment,
    "ManagedBy"   = "Terraform"
  })
}

 resource "aws_subnet" "this" {
    vpc_id = aws_vpc.this.id
    cidr_block = var.env_subnet_1a
    availability_zone = var.azs
    map_public_ip_on_launch = var.map_public_ip_on_launch

  tags = merge({
    "Name"        = "${var.project_domain}-${var.environment}",
    "Description" = var.description,
    "Environment" = var.environment,
    "ManagedBy"   = "Terraform"
  })
}

resource "aws_route_table_association" "rta" {
  subnet_id      = aws_subnet.this.id
  route_table_id = aws_route_table.this.id
}

resource "aws_security_group" "allow_traffic" {
  name        = "allow_web_traffic"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.this.id

  ingress {
    description      = "HTTPS "
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }
  ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
   
  }
  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }


  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_traffic-default-vpc-sg"
  }
}

resource "aws_network_interface" "SunnyVpcNI" {
  subnet_id       = aws_subnet.this.id
  private_ips     = ["10.102.1.50"]
  security_groups = [aws_security_group.allow_traffic.id]
}