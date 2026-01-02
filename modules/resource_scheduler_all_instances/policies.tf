locals {
  schedule_rule_text    = "Allow any-user to manage instance in tenancy where all {request.principal.type='resourceschedule', request.principal.id='"
  original_policies     = [
    "Allow group ${local.schedule_group_id} to manage resource-schedule in tenancy",
    "Allow group ${local.schedule_group_id} to inspect resource-schedule in tenancy",
    "Allow group ${local.schedule_group_id} to manage resource-schedule-family in tenancy",
    "Allow group ${local.schedule_group_id} to read resource-schedule-workrequest in tenancy",
    "Allow group ${local.schedule_group_id} to inspect resource-schedule-workrequest in tenancy",
    "Allow group ${local.schedule_group_id} to manage instance-family in tenancy",
    "Allow group ${local.schedule_group_id} to manage instance-console-connection in tenancy",
    "Allow group ${local.schedule_group_id} to read instance in tenancy"
  ]
  extra_start_policies  = [ for k,v in oci_resource_scheduler_schedule.start_schedule : format("%s%s%s", local.schedule_rule_text, v.id, "'}")] 
  extra_stop_policies   = [ for k,v in oci_resource_scheduler_schedule.stop_schedule : format("%s%s%s", local.schedule_rule_text, v.id, "'}")] 
  schedule_policies     = concat(local.original_policies, local.extra_start_policies, local.extra_stop_policies)
  #schedule_policies     = concat(local.extra_start_policies)
  #schedule_policies     = local.original_policies
}
