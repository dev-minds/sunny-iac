
variable "inst_ami" {
    description = "Specify instance AMI"
}

variable "inst_type" {
    description = "Specify instance type"
}

variable "inst_azs" {
    description = "Specify instance AZs"
}

variable "nic_dev_index" {
    description = "Specify NIC id"
}

variable "nic_int_val" {
    description = "Specify NIC int value"
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

