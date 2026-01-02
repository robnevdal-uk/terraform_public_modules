data "oci_identity_domains_groups" "scheduler_group" {
  idcs_endpoint                      = var.idcs_endpoint
}

locals {
  values                             = { for k,v in data.oci_identity_domains_groups.scheduler_group.groups : v.display_name=> {id = v.ocid}}
  schedule_group_ocid                = lookup(local.values, var.schedule_group_name)
  schedule_group_id                  = local.schedule_group_ocid.id
}

resource "oci_identity_policy" scheduler_policy {
  compartment_id                     = local.compartment_id
  description                        = var.schedule_policy_description
  name                               = var.schedule_policy_name
  statements                         = local.extra_policies
  depends_on                         = [ oci_resource_scheduler_schedule.schedule_start ]
}
