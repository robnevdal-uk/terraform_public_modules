data "oci_identity_compartments" "subnet_compartment" {
  compartment_id                   = var.tenancy_ocid
  #compartment_id_in_subtree        = true
  name                             = var.subnet_compartment_name
  state                            = "ACTIVE"
}

data "oci_identity_compartments" "subnet_parent_compartment" {
  compartment_id                   = var.tenancy_ocid
  compartment_id_in_subtree        = "true"
  state                            = "ACTIVE"
}

data "oci_identity_compartments" "subnet_all_compartment" {
  compartment_id                   = var.tenancy_ocid
  compartment_id_in_subtree        = "true"
  state                            = "ACTIVE"
}

data "oci_identity_compartments" "subnet_duplicate_compartment" {
  compartment_id                   = local.subnet_parent_id
  state                            = "ACTIVE"
  name                             = var.subnet_compartment_name
}

data "oci_core_subnets" "subnet" {
  display_name                     = var.subnet_name
  compartment_id                   = local.subnet_compartment_id
}

locals {
  subnet_all_parents               = distinct([ for v in data.oci_identity_compartments.subnet_parent_compartment.compartments : v.compartment_id])
  subnet_tenancy                   = { (var.tenancy_ocid)="Tenancy"}
  subnet_all_comps                 = { for i in data.oci_identity_compartments.subnet_all_compartment.compartments : i.id => i.name }
  subnet_all_comps_plus_tenancy    = merge(local.subnet_tenancy, local.subnet_all_comps)
  subnet_all_parent_names          = { for p in local.subnet_all_parents : lookup(local.subnet_all_comps_plus_tenancy,p) => p}
  subnet_parent_id                 = lookup(local.subnet_all_parent_names, var.subnet_parent_compartment_name)
  subnet_duplicate_compartment_id  = var.subnet_duplicate_compartment == true ? data.oci_identity_compartments.subnet_duplicate_compartment.compartments[0].id : null
  subnet_compartment_id            = var.subnet_duplicate_compartment == true ? local.subnet_duplicate_compartment_id : data.oci_identity_compartments.subnet_compartment.compartments[0].id
  subnet_id                        = var.subnet_name == "" ? "" : data.oci_core_subnets.subnet.subnets[0].id
}

