resource "aws_elasticache_cluster" "example" {
  cluster_id           = var.cluster_id_name
  engine               = var.cluster_engine
  node_type            = var.cluster_node_type
  num_cache_nodes      = var.cluster_num_cach_nodes
  parameter_group_name = var.parameter_group_name
  engine_version       = var.engine_version
  port                 = var.cluster_port

  tags = merge({
    "Name"        = "${var.project_domain}-${var.environment}-elc",
    "Description" = var.description,
    "Environment" = var.environment,
    "ManagedBy"   = "Terraform"
  })
}