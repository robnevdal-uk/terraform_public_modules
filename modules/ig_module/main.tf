resource "oci_core_internet_gateway" "internet_gateway" {
  vcn_id         = var.vcn_id
  compartment_id = local.compartment_id
  display_name   = var.vcn_internet_gateway_name
}
