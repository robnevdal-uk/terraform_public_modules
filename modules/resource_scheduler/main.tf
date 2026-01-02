resource "oci_resource_scheduler_schedule" "schedule_static" {
  count                                           = var.dynamic != 1 ? 1 : 0
  action                                          = var.schedule_action
  compartment_id                                  = local.compartment_id
  recurrence_details                              = var.schedule_recurrence_details
  recurrence_type                                 = var.schedule_recurrence_type
  description                                     = var.schedule_description
  display_name                                    = var.schedule_display_name
  resources {
    id                                            = var.schedule_resources_id
  }
  time_ends                                       = var.schedule_time_ends
  time_starts                                     = var.schedule_time_starts
}

resource "oci_resource_scheduler_schedule" "schedule_dynamic" {
  count                                           = var.dynamic == 1 ? 1 : 0
  action                                          = var.schedule_action
  compartment_id                                  = local.compartment_id
  recurrence_details                              = var.schedule_recurrence_details
  recurrence_type                                 = var.schedule_recurrence_type
  description                                     = var.schedule_description
  display_name                                    = var.schedule_display_name
  resource_filters {
    attribute                                     = var.schedule_resource_filters_attribute
      value {
        namespace                                 = var.schedule_resource_filters_value_namespace
        tag_key                                   = var.schedule_resource_filters_value_tag_key
        value                                     = var.schedule_resource_filters_value_value
      }
    }
  resource_filters {
    attribute                                     = "RESOURCE_TYPE"
      value {
        value                                     = "Instance,AutonomousDatabase"
      }
    }
  time_ends                                       = var.schedule_time_ends
  time_starts                                     = var.schedule_time_starts
}

locals {
  schedule_rule_text    = "Allow any-user to manage instance in tenancy where all {request.principal.type='resourceschedule', request.principal.id='"
  extra_policies        = var.dynamic == 1 ? formatlist("%s%s%s", local.schedule_rule_text, oci_resource_scheduler_schedule.schedule_dynamic[0].id, "'}") : formatlist("%s%s%s", local.schedule_rule_text, oci_resource_scheduler_schedule.schedule_static[0].id, "'}")
}
