resource "oci_core_local_peering_gateway" "peering_gateway_peered" {
  count          = var.peer == true ? 1 : 0
  vcn_id         = var.vcn_id
  compartment_id = local.compartment_id
  display_name   = var.peering_gateway_name
  peer_id        = var.peer_id 
}

resource "oci_core_local_peering_gateway" "peering_gateway_not_peered" {
  count          = var.peer != true ? 1 : 0
  vcn_id         = var.vcn_id
  compartment_id = local.compartment_id
  display_name   = var.peering_gateway_name
}
