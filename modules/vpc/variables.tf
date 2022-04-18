
variable "cidr" {
    description = "Specify cidr block for this VPC"
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

variable "dns_support" {
    description = "Specify true or false to enable DNS support"
}

variable "dns_hostn" {
    description = "Specify true or false to enable DNS hostname"
}

variable "inst_tenancy" {
    description = "Specify instance tenancy for this VPC"
}

variable "env_subnet_1a" {
    description = "Specify subnet range"
}

variable "azs" {
    description = "Specify AZs"
}

variable "map_public_ip_on_launch" {
    description = "Specify true or false to enable public IP assignment"
}

