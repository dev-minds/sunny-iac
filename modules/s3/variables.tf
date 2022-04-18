variable "bucket-name" {
    description = "Specify bucket name"
}

variable "bucket_acl" {
    description = "Spacify bucket acl"
}

variable "enable_versioning"  {
    description = "Specify to enable versioning or not"
} 

variable "description" {
    description = "Specify a description for bucket resource"
}

variable "project_domain" {
    description = "Specify project domain name for the bucket resource"
}

variable "environment" {
    description = "Specify environment for bucket creation"
}