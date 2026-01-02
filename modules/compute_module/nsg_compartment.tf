data "oci_identity_compartments" "nsg_compartment" {
  compartment_id                   = var.tenancy_ocid
  compartment_id_in_subtree        = true
  name                             = var.nsg_compartment_name
  state                            = "ACTIVE"
}

data "oci_identity_compartments" "nsg_parent_compartment" {
  compartment_id                   = var.tenancy_ocid
  compartment_id_in_subtree        = "true"
  state                            = "ACTIVE"
}

data "oci_identity_compartments" "nsg_all_compartment" {
  compartment_id                   = var.tenancy_ocid
  compartment_id_in_subtree        = "true"
  state                            = "ACTIVE"
}

data "oci_identity_compartments" "nsg_duplicate_compartment" {
  compartment_id                   = local.nsg_parent_id
  state                            = "ACTIVE"
  name                             = var.nsg_compartment_name
}

locals {
  nsg_all_parents                  = distinct([ for v in data.oci_identity_compartments.nsg_parent_compartment.compartments : v.compartment_id])
  nsg_tenancy                      = { (var.tenancy_ocid)="Tenancy"}
  nsg_all_comps                    = { for i in data.oci_identity_compartments.nsg_all_compartment.compartments : i.id => i.name }
  nsg_all_comps_plus_tenancy       = merge(local.nsg_tenancy, local.nsg_all_comps)
  nsg_all_parent_names             = { for p in local.nsg_all_parents : lookup(local.nsg_all_comps_plus_tenancy,p) => p}
  nsg_parent_id                    = lookup(local.nsg_all_parent_names, var.nsg_parent_compartment_name)
  nsg_duplicate_compartment_id     = var.nsg_duplicate_compartment == true ? data.oci_identity_compartments.nsg_duplicate_compartment.compartments[0].id : null
  nsg_compartment_id               = var.nsg_duplicate_compartment == true ? local.nsg_duplicate_compartment_id : data.oci_identity_compartments.nsg_compartment.compartments[0].id 
}

