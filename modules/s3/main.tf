resource "random_string" "random" {
  length           = 7
  special          = false
  override_special = "/@£$"
  upper = false
}

resource "aws_s3_bucket" "this" {
  bucket = "${var.bucket-name}-${random_string.random.result}"
  acl    = var.bucket_acl

  versioning {
    enabled = var.enable_versioning
  }

  tags = {
    "Name"          = var.bucket-name, 
    "Description"   = var.description,
    "ProjectDomain" = var.project_domain,
    "Environment"   = var.environment,
    "ManagedBy"     = "Terraform"
  }
}