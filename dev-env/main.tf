# ==================================================================
# Terraform version constraints
# ==================================================================
terraform {
  required_version = ">= 1.1.2"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.0"
    }
  }
}


# ==================================================================
# Provider plugins 
# ==================================================================
provider "aws" {
  region = "eu-west-1"
}

# ==================================================================
# State location  
# ==================================================================
terraform {
  backend "s3" {
    bucket  = "vpc-states"
    region  = "eu-west-1"
    key     = "iuri-iac-sunny/dev-env/terraform.tfstate"
    encrypt = true
    acl     = "private"

    session_name = "dev-provisioner"
  }
}

# ==================================================================
# Service calls - VPC | ELC | S3 | EC2-Compute 
# ==================================================================


# ======================
# VPC 
# ======================
module "dev_vpc" {
  source = "../modules/vpc/"

  cidr           = "10.102.0.0/16"
  project_domain = "sunny-backend"
  dns_support    = true
  dns_hostn      = true
  inst_tenancy   = "default"
  environment    = "dev"

  # Subnet Defitions 
  env_subnet_1a           = "10.102.1.0/24"
  azs                     = "eu-west-1a"
  map_public_ip_on_launch = true

  description = "VPC configs for dev"
}


# ======================
# ELC
# ======================
module "dev_elc" {
  source = "../modules/elc/"

  cluster_id_name        = "sunny-backend"
  cluster_engine         = "redis"
  cluster_node_type      = "cache.m4.large"
  cluster_num_cach_nodes = "1"
  parameter_group_name   = "default.redis3.2"
  engine_version         = "3.2.10"
  cluster_port           = 6379
  project_domain         = "sunny-backend"
  environment            = "dev"
  description            = "Dev Elasticache cluster"

}

# ======================
# WebsErver
# ======================
module "dev_server" {
  source = "../modules/ec2-compute/"

  inst_ami      = "ami-0f29c8402f8cce65c"
  inst_type     = "t2.micro"
  inst_azs      = "eu-west-1a"
  nic_dev_index = "0"
#   nic_int_val   = module.dev_vpc.aws_network_interface.this.id
  nic_int_val   = "eni-0db0b5f63c6cde571"
  project_domain         = "sunny-backend"
  environment            = "dev"
  description            = "Dev webserver description cluster"
}

# ======================
# S3
# ======================
module "dev_s3" {
  source = "../modules/s3/"

  bucket-name       = "first-bucket-test"
  bucket_acl        = "private"
  enable_versioning = true
  project_domain    = "sunny-backend"
  environment       = "dev"
  description       = "s3 bucket for dev env works"
}

