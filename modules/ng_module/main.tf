resource "oci_core_nat_gateway" "nat_gateway" {
  vcn_id         = var.vcn_id
  compartment_id = local.compartment_id
  display_name   = var.nat_gateway_name
  block_traffic  = var.block_traffic_on_gateway
}
