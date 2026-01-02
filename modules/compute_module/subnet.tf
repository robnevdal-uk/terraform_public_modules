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
  for_each                         = local.all_subnets2
  compartment_id                   = local.all_subnets2[each.key].parent_compartment_id
  state                            = "ACTIVE"
  name                             = local.all_subnets2[each.key].subnet_compartment_name
}

data "oci_identity_compartments" "subnet_compartment" {
  for_each                         = local.all_subnets2
  compartment_id                   = var.tenancy_ocid
  compartment_id_in_subtree        = true
  name                             = local.all_subnets2[each.key].subnet_compartment_name
  state                            = "ACTIVE"
}

data "oci_core_subnets" "subnet" {
  for_each                         = { for i,s in local.all_subnets3 : i => s}
  display_name                     = each.value["subnet_name"]
  compartment_id                   = each.value["subnet_compartment_id"]
}

locals {
  subnet_all_parents               = distinct([ for v in data.oci_identity_compartments.subnet_parent_compartment.compartments : v.compartment_id])
  subnet_tenancy                   = { (var.tenancy_ocid)="Tenancy"}
  subnet_all_comps                 = { for i in data.oci_identity_compartments.subnet_all_compartment.compartments : i.id => i.name }
  subnet_all_comps_plus_tenancy    = merge(local.subnet_tenancy, local.subnet_all_comps)
  subnet_all_parent_names          = { for p in local.subnet_all_parents : lookup(local.subnet_all_comps_plus_tenancy,p) => p}
  all_subnets                      = { for k,v in var.subnet_details : k => { subnet_name = v.subnet_name
                                                                              subnet_compartment_name = v.subnet_compartment_name
                                                                              parent_compartment_name = v.parent_compartment_name == null ? "Tenancy" : v.parent_compartment_name
                                                                              duplicate_compartment = v.duplicate_compartment
                                                                            }}
  all_subnets2                     = { for k,v in local.all_subnets : k => { subnet_name = v.subnet_name
                                                                             subnet_compartment_name = v.subnet_compartment_name
                                                                             parent_compartment_id = lookup(local.subnet_all_parent_names, v.parent_compartment_name)
                                                                             duplicate_compartment = v.duplicate_compartment
                                                                           }}
  all_subnets3                     = { for k,v in local.all_subnets2 : k => { subnet_name = v.subnet_name
                                                                              subnet_compartment_id = v.duplicate_compartment == true ? data.oci_identity_compartments.subnet_duplicate_compartment[k].compartments[0].id : data.oci_identity_compartments.subnet_compartment[k].compartments[0].id
                                                                            }}
  subnet_ids                       = { for k,v in local.all_subnets3 : k => {
                                                                               subnet_id = data.oci_core_subnets.subnet[k].subnets[*].id
                                                                            }
                                     }
  subnet_ocids                     = flatten([ for v in local.subnet_ids : v.subnet_id ])
}
