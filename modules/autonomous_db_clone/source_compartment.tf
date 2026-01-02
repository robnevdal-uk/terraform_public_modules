data "oci_identity_compartments" "source_compartment" {
  compartment_id                   = var.tenancy_ocid
  compartment_id_in_subtree        = true
  name                             = var.source_compartment_name
  state                            = "ACTIVE"
}

data "oci_identity_compartments" "source_parent_compartment" {
  compartment_id                   = var.tenancy_ocid
  compartment_id_in_subtree        = "true"
  state                            = "ACTIVE"
}

data "oci_identity_compartments" "source_all_compartment" {
  compartment_id                   = var.tenancy_ocid
  compartment_id_in_subtree        = "true"
  state                            = "ACTIVE"
}

data "oci_identity_compartments" "source_duplicate_compartment" {
  compartment_id                   = local.parent_id
  state                            = "ACTIVE"
  name                             = var.source_compartment_name
}

locals {
  source_all_parents               = distinct([ for v in data.oci_identity_compartments.source_parent_compartment.compartments : v.compartment_id])
  source_tenancy                   = { (var.tenancy_ocid)="Tenancy"}
  source_all_comps                 = { for i in data.oci_identity_compartments.source_all_compartment.compartments : i.id => i.name }
  source_all_comps_plus_tenancy    = merge(local.source_tenancy, local.source_all_comps)
  source_all_parent_names          = { for p in local.source_all_parents : lookup(local.source_all_comps_plus_tenancy,p) => p}
  source_parent_id                 = lookup(local.source_all_parent_names, var.source_parent_compartment_name)
  source_duplicate_compartment_id  = var.source_duplicate_compartment == true ? data.oci_identity_compartments.source_duplicate_compartment.compartments[0].id : null
  source_compartment_id            = var.source_duplicate_compartment == true ? local.source_duplicate_compartment_id : data.oci_identity_compartments.source_compartment.compartments[0].id 
}

