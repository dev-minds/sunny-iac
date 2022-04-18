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

module "dev_vpc" {
  source = "../modules/vpc/"

  cidr              = "10.102.0.0/16"
  project_domain    = "sunny-backend"
  dns_support       = true
  dns_hostn         = true 
  inst_tenancy      = "default"
  environment       = "dev"

  env_subnet_1a     = "10.102.1.0/24"
  azs               = "eu-west-1a"
  map_public_ip_on_launch = true

  description       = "VPC configs for dev"
}

module "dev_s3" {
  source = "../modules/s3/"

  bucket-name       = "first-bucket-test"
  bucket_acl        = "private"
  enable_versioning = true
  project_domain    = "sunny-backend"
  environment       = "dev"
  description       = "s3 bucket for dev env works"
}

