data "oci_identity_compartments" "compartment" {
  compartment_id                   = var.tenancy_ocid
  compartment_id_in_subtree        = true
  name                             = var.compartment_name
  state                            = "ACTIVE"
}

locals {
  compartment_id                   = var.compartment_name == "fujitsurp" ? var.tenancy_ocid : data.oci_identity_compartments.compartment.compartments[0].id
}
