locals {
  gateway_compartment_name   = "<Enter Compart,emt Name>"
  service_gateway_name       = "<Enter Name of SG>"
}

module "service_gateway" {
  source                     = "../../modules/sg_module"
  tenancy_ocid               = var.tenancy_ocid
  service_gateway_name       = local.service_gateway_name
  vcn_id                     = <Enter OCID of VCN>
  compartment_name           = local.gateway_compartment_name
  # Enter 2 Lines Below if Compartment is not unique
  parent_compartment_name    = "<Enter Parent Compartment Name of Compartment>"
  duplicate_compartment      = "true"
}
