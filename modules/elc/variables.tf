

variable "cluster_id_name" {
    description = "Specify cluster name/id"
}

variable "cluster_engine" {
    description = "Specify cluster engine type"
}

variable "cluster_node_type" {
    description = "Specify node type for cluster"
}

variable "cluster_num_cach_nodes" {
    description = "Specify number of cache nodes"
}

variable "parameter_group_name" {
    description = "Specify params group"
}

variable "engine_version" {
    description = "Specify engine_version"
}

variable "cluster_port" {
    description = "Specify cluster port number"
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

