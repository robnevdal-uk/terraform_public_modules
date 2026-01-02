data "oci_identity_compartments" "compartment" {
  compartment_id                   = var.tenancy_ocid
  compartment_id_in_subtree        = true
  name                             = var.compartment_name
  state                            = "ACTIVE"
}

data "oci_identity_compartments" "parent_compartment" {
  compartment_id                   = var.tenancy_ocid
  compartment_id_in_subtree        = "true"
  state                            = "ACTIVE"
}

data "oci_identity_compartments" "all_compartment" {
  compartment_id                   = var.tenancy_ocid
  compartment_id_in_subtree        = "true"
  state                            = "ACTIVE"
}

data "oci_identity_compartments" "duplicate_compartment" {
  compartment_id                   = local.parent_id
  state                            = "ACTIVE"
  name                             = var.compartment_name
}

locals {
  all_parents                      = distinct([ for v in data.oci_identity_compartments.parent_compartment.compartments : v.compartment_id])
  tenancy                          = { (var.tenancy_ocid)="Tenancy"}
  all_comps                        = { for i in data.oci_identity_compartments.all_compartment.compartments : i.id => i.name }
  all_comps_plus_tenancy           = merge(local.tenancy, local.all_comps)
  all_parent_names                 = { for p in local.all_parents : lookup(local.all_comps_plus_tenancy,p) => p}
  parent_id                        = lookup(local.all_parent_names, var.parent_compartment_name)
  duplicate_compartment_id         = var.duplicate_compartment == true ? data.oci_identity_compartments.duplicate_compartment.compartments[0].id : null
  compartment_id                   = var.duplicate_compartment == true ? local.duplicate_compartment_id : data.oci_identity_compartments.compartment.compartments[0].id 
}

