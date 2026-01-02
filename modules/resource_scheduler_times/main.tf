resource "oci_resource_scheduler_schedule" "schedule_start" {
  for_each                                        = toset(var.start_times)
  action                                          = var.schedule_action_start
  compartment_id                                  = local.compartment_id
  recurrence_details                              = var.schedule_recurrence_details
  recurrence_type                                 = var.schedule_recurrence_type
  description                                     = format("%s_%s_at_%s:00", var.schedule_description, "Start", each.value)
  display_name                                    = format("%s_%s_%s:00", var.schedule_display_name, "Start", each.value)
  resource_filters {
    attribute                                     = var.schedule_resource_filters_attribute
      value {
        namespace                                 = var.schedule_resource_filters_value_namespace
        tag_key                                   = var.schedule_resource_filters_value_tag_key_start
        value                                     = each.value
      }
    }
  resource_filters {
    attribute                                     = "RESOURCE_TYPE"
      value {
        value                                     = "Instance,AutonomousDatabase"
      }
    }
  time_starts                                     = format("%sT%s:00:00Z",local.schedule_date_starts,each.value)
  time_ends                                       = null
}

resource "oci_resource_scheduler_schedule" "schedule_stop" {
  for_each                                        = toset(var.stop_times)
  action                                          = var.schedule_action_stop
  compartment_id                                  = local.compartment_id
  recurrence_details                              = var.schedule_recurrence_details
  recurrence_type                                 = var.schedule_recurrence_type
  description                                     = format("%s_%s_at_%s:00", var.schedule_description, "Stop", each.value)
  display_name                                    = format("%s_%s_%s:00", var.schedule_display_name, "Stop", each.value)
  resource_filters {
    attribute                                     = var.schedule_resource_filters_attribute
      value {
        namespace                                 = var.schedule_resource_filters_value_namespace
        tag_key                                   = var.schedule_resource_filters_value_tag_key_stop
        value                                     = each.value
      }
    }
  resource_filters {
    attribute                                     = "RESOURCE_TYPE"
      value {
        value                                     = "Instance,AutonomousDatabase"
      }
    }
  time_starts                                     = format("%sT%s:00:00Z",local.schedule_date_starts,each.value)
  time_ends                                       = null
}

locals {
  schedule_rule_text                              = "Allow any-user to manage instance in tenancy where all {request.principal.type='resourceschedule', request.principal.id='"
  #extra_policies                                  = formatlist("%s%s%s", local.schedule_rule_text, oci_resource_scheduler_schedule.schedule_start[each.key].id, "'}") 
  extra_policies_stop                             = [ for i in oci_resource_scheduler_schedule.schedule_stop : format("%s%s'}", local.schedule_rule_text, i.id) ]
  extra_policies_start                            = [ for i in oci_resource_scheduler_schedule.schedule_start : format("%s%s'}", local.schedule_rule_text, i.id)]
  extra_policies                                  = concat(local.extra_policies_stop, local.extra_policies_start)
  schedule_date_starts                            = substr(timeadd(timestamp(), "24h"), 0, 10)
}

output "pol" {
  value = local.extra_policies
}
