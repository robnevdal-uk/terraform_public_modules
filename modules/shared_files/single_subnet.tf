data "oci_core_subnets" "subnet" {
  display_name                     = var.subnet_name
  compartment_id                   = local.subnet_compartment_id
}

locals {
  subnet_id                        = data.oci_core_subnets.subnet.subnets[*].id
}
