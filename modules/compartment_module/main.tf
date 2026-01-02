resource "oci_identity_compartment" "oci_compartment" {
  compartment_id             = var.parent_compartment_id
  name                       = var.compartment_name
  description                = var.compartment_description
}
