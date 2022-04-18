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

module "dev_s3" {
  source = "../modules/s3/"

  bucket-name       = "first-bucket-test"
  bucket_acl        = "private"
  enable_versioning = true
  project_domain    = "sunny-backend"
  environment       = "dev"
  description       = "s3 bucket for dev env works"
}