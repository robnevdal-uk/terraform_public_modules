locals {
  gateway_compartment_name   = "<Enter Compart,emt Name>"
  peering_gateway_name       = "<Enter Name of LPG>"
}

module "local_peering_gateway" {
  source                     = "../lpg_module"
  tenancy_ocid               = var.tenancy_ocid
  peering_gateway_name       = local.peering_gateway_name
  vcn_id                     = <Enter OCID of VCN>
  compartment_name           = local.gateway_compartment_name
  peer                       = "True or False if the peering gateway is to be peered"
  # Enter Below if peer is set to true
  peer_id                    = "OCID of Peered LPG" 
  # Enter 2 Lines Below if Compartment is not unique
  parent_compartment_name    = "<Enter Parent Compartment Name of Compartment>"
  duplicate_compartment      = "true"
}
