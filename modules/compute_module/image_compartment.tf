data "oci_identity_compartments" "image_compartment" {
  compartment_id                   = var.tenancy_ocid
  compartment_id_in_subtree        = true
  name                             = var.image_compartment_name
  state                            = "ACTIVE"
}

data "oci_identity_compartments" "image_parent_compartment" {
  compartment_id                   = var.tenancy_ocid
  compartment_id_in_subtree        = "true"
  state                            = "ACTIVE"
}

data "oci_identity_compartments" "image_all_compartment" {
  compartment_id                   = var.tenancy_ocid
  compartment_id_in_subtree        = "true"
  state                            = "ACTIVE"
}

data "oci_identity_compartments" "image_duplicate_compartment" {
  compartment_id                   = local.image_parent_id
  state                            = "ACTIVE"
  name                             = var.image_compartment_name
}

locals {
  image_all_parents                = distinct([ for v in data.oci_identity_compartments.image_parent_compartment.compartments : v.compartment_id])
  image_tenancy                    = { (var.tenancy_ocid)="Tenancy"}
  image_all_comps                  = { for i in data.oci_identity_compartments.image_all_compartment.compartments : i.id => i.name }
  image_all_comps_plus_tenancy     = merge(local.image_tenancy, local.image_all_comps)
  image_all_parent_names           = { for p in local.image_all_parents : lookup(local.image_all_comps_plus_tenancy,p) => p}
  image_parent_id                  = lookup(local.image_all_parent_names, var.image_parent_compartment_name)
  image_duplicate_compartment_id   = var.image_duplicate_compartment == true ? data.oci_identity_compartments.image_duplicate_compartment.compartments[0].id : null
  image_compartment_id             = var.image_duplicate_compartment == true ? local.image_duplicate_compartment_id : data.oci_identity_compartments.image_compartment.compartments[0].id 
}

