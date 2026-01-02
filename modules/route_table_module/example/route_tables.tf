locals {
  route_table_name              = "<Enter Route Table Name>"
  oci_route_table_rule = {
    rule1 = {
      description               = "<Enter Rule Desc>"
      destination               = "0.0.0.0/0"
      destination_type          = "CIDR_BLOCK"
      network_entity_id         = "<Enter OCID of Network Entity>"
    }
  }
  oci_route_table_service_rule  = {
    rule1 = {
      description               = "<Enter Rule Desc>"
      network_entity_id         = "<Enter OCID of Service Gateway>"
    }
  }
}

module "route_table_for_private_subnet" {
  source                       = "../route_table_module"
  compartment_name             = var.compartment_name            
  vcn_id                       = module.fj_nw_vcn.id
  route_table_name             = local.route_table_name
  oci_route_table_rule         = local.oci_route_table_rule
  oci_route_table_service_rule = local.oci_route_table_service_rule
  # Enter 2 Lines Below if Compartment is not unique
  parent_compartment_name    = "<Enter Parent Compartment Name of Compartment>"
  duplicate_compartment      = "true"
}

