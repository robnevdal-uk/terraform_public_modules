locals {
  gateway_compartment_name   = "<Enter Compart,emt Name>"
  internet_gateway_name      = "<Enter Name of IG>"
}

module "internet_gateway" {
  source                     = "../../modules/ig_module"
  tenancy_ocid               = var.tenancy_ocid
  vcn_internet_gateway_name  = local.internet_gateway_name
  vcn_id                     = <Enter OCID of VCN>
  compartment_name           = local.gateway_compartment_name
  # Enter 2 Lines Below if Compartment is not unique
  parent_compartment_name    = "<Enter Parent Compartment Name of Compartment>"
  duplicate_compartment      = "true"
}
