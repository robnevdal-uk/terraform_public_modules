data "oci_identity_compartments" "instance_parent_compartment" {
  compartment_id                   = var.tenancy_ocid
  compartment_id_in_subtree        = "true"
  state                            = "ACTIVE"
}

data "oci_identity_compartments" "instance_all_compartment" {
  compartment_id                   = var.tenancy_ocid
  compartment_id_in_subtree        = "true"
  state                            = "ACTIVE"
}

data "oci_identity_compartments" "instance_duplicate_compartment" {
  for_each                         = local.all_instances2
  compartment_id                   = local.all_instances2[each.key].parent_compartment_id
  state                            = "ACTIVE"
  name                             = local.all_instances2[each.key].instance_compartment_name
}

data "oci_identity_compartments" "instance_compartment" {
  for_each                         = local.all_instances2
  compartment_id                   = var.tenancy_ocid
  compartment_id_in_subtree        = true
  name                             = local.all_instances2[each.key].instance_compartment_name
  state                            = "ACTIVE"
}

data "oci_core_instances" "instance" {
  for_each                         = { for i,s in local.all_instances3 : i => s}
  display_name                     = each.value["instance_name"]
  compartment_id                   = each.value["instance_compartment_id"]
}

locals {
  instance_all_parents             = distinct([ for v in data.oci_identity_compartments.instance_parent_compartment.compartments : v.compartment_id])
  instance_tenancy                 = { (var.tenancy_ocid)="Tenancy"}
  instance_all_comps               = { for i in data.oci_identity_compartments.instance_all_compartment.compartments : i.id => i.name }
  instance_all_comps_plus_tenancy  = merge(local.instance_tenancy, local.instance_all_comps)
  instance_all_parent_names        = { for p in local.instance_all_parents : lookup(local.instance_all_comps_plus_tenancy,p) => p}
  all_instances                    = { for k,v in var.instance_details : k => { instance_name = v.instance_name
                                                                                instance_compartment_name = v.instance_compartment_name
                                                                                parent_compartment_name = v.parent_compartment_name == null ? "Tenancy" : v.parent_compartment_name
                                                                                duplicate_compartment = v.duplicate_compartment
                                                                            }}
  all_instances2                   = { for k,v in local.all_instances : k => { instance_name = v.instance_name
                                                                               instance_compartment_name = v.instance_compartment_name
                                                                               parent_compartment_id = lookup(local.instance_all_parent_names, v.parent_compartment_name)
                                                                               duplicate_compartment = v.duplicate_compartment
                                                                           }}
  all_instances3                   = { for k,v in local.all_instances2 : k => { instance_name = v.instance_name
                                                                                instance_compartment_id = v.duplicate_compartment == true ? data.oci_identity_compartments.instance_duplicate_compartment[k].compartments[0].id : data.oci_identity_compartments.instance_compartment[k].compartments[0].id
                                                                            }}
  instance_ids                     = { for k,v in local.all_instances3 : k => {
                                                                               instance_id = data.oci_core_instances.instance[k].instances[*].id
                                                                            }
                                     }
  instance_ocids                   = flatten([ for v in local.instance_ids : v.instance_id ])
  all_instances_to_start           = { for k,v in var.instance_details : k => { instance_name = v.instance_name
                                                                                instance_compartment_name = v.instance_compartment_name
                                                                                parent_compartment_name = v.parent_compartment_name == null ? "Tenancy" : v.parent_compartment_name
                                                                                duplicate_compartment = v.duplicate_compartment
                                                                              } if v.start == true}
  all_instances_to_start2          = { for k,v in local.all_instances_to_start : k => { instance_name = v.instance_name
                                                                                        instance_compartment_name = v.instance_compartment_name
                                                                                        parent_compartment_id = lookup(local.instance_all_parent_names, v.parent_compartment_name)
                                                                                        duplicate_compartment = v.duplicate_compartment
                                                                                      }}
  all_instances_to_start3          = { for k,v in local.all_instances_to_start2 : k => { instance_name = v.instance_name
                                                                                         instance_compartment_id = v.duplicate_compartment == true ? data.oci_identity_compartments.instance_duplicate_compartment[k].compartments[0].id : data.oci_identity_compartments.instance_compartment[k].compartments[0].id
                                                                                       }}
  instance_ids_to_start            = { for k,v in local.all_instances_to_start3 : k => { instance_id = data.oci_core_instances.instance[k].instances[*].id }
                                     }
  instance_ocids_to_start          = flatten([ for v in local.instance_ids_to_start : v.instance_id ])
}

