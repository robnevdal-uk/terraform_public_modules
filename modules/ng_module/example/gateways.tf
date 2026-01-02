locals {
  gateway_compartment_name   = "<Enter Compart,emt Name>"
  nat_gateway_name           = "<Enter Name of NG>"
}

module "nat_gateway" {
  source                     = "../../modules/ng_module"
  tenancy_ocid               = var.tenancy_ocid
  nat_gateway_name           = local.nat_gateway_name
  vcn_id                     = <Enter OCID of VCN>
  compartment_name           = local.gateway_compartment_name
  block_traffic_on_gateway   = "false"
  # Enter 2 Lines Below if Compartment is not unique
  parent_compartment_name    = "<Enter Parent Compartment Name of Compartment>"
  duplicate_compartment      = "true"
}
