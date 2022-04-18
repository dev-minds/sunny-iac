resource "aws_instance" "web-server_1_Sunny" {
    ami               = var.inst_ami
    instance_type     = var.inst_type
    availability_zone = var.inst_azs
   
    network_interface {
      device_index = var.nic_dev_index
      network_interface_id = var.nic_int_val
    }

  tags = merge({
    "Name"        = "${var.project_domain}-${var.environment}-webserver",
    "Description" = var.description,
    "Environment" = var.environment,
    "ManagedBy"   = "Terraform"
  })
    
}