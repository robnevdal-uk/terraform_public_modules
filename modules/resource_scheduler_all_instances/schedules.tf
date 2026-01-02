locals {
  schedule_date_starts        = substr(timeadd(timestamp(), "24h"), 0, 10)
  schedule_time_starts        = format("%sT%sZ", local.schedule_date_starts, var.schedule_time_starts)
  schedule_date_ends          = substr(timestamp(), 0, 10)
  schedule_time_ends          = format("%sT%sZ", local.schedule_date_ends, var.schedule_time_ends)
}
data "oci_core_instance" "instance_name" {
  count                       = length(local.instance_ocids)
  instance_id                 = local.instance_ocids[count.index]
}

data "oci_core_instance" "instance_name_to_start" {
  count                       = length(local.instance_ocids_to_start)
  instance_id                 = local.instance_ocids_to_start[count.index]
}

resource "oci_resource_scheduler_schedule" "start_schedule" {
  #for_each                    = local.instance_ocids
  count                       = length(local.instance_ocids_to_start)
  action                      = var.schedule_action_start
  compartment_id              = local.compartment_id
  recurrence_details          = var.schedule_recurrence_details
  recurrence_type             = var.schedule_recurrence_type
  description                 = format("%s %s", "Start Instance", data.oci_core_instance.instance_name_to_start[count.index].display_name)
  display_name                = format("%s %s", "Start Instance", data.oci_core_instance.instance_name_to_start[count.index].display_name)
  resources {
    id                        = local.instance_ocids_to_start[count.index]
  }
  time_ends                   = null
  time_starts                 = local.schedule_time_starts
}

resource "oci_resource_scheduler_schedule" "stop_schedule" {
  #for_each                    = local.instance_ocids
  count                       = length(local.instance_ocids)
  action                      = var.schedule_action_stop
  compartment_id              = local.compartment_id
  recurrence_details          = var.schedule_recurrence_details
  recurrence_type             = var.schedule_recurrence_type
  description                 = format("%s %s", "Stop Instance", data.oci_core_instance.instance_name[count.index].display_name)
  display_name                = format("%s %s", "Stop Instance", data.oci_core_instance.instance_name[count.index].display_name)
  resources {
    id                        = local.instance_ocids[count.index]
  }
  time_ends                   = null
  time_starts                 = local.schedule_time_ends
}
