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

 resource "aws_subnet" "subnet_1" {
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