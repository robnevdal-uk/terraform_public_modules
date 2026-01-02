locals {
  oci_default_route_table_rule         = {
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
  oci_default_route_table_service_rule = {}
}
