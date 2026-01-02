variable tenancy_ocid {
  type=string
}
variable schedule_action_start {
  type=string
  default="START_RESOURCE"
}
variable schedule_action_stop {
  type=string
  default="STOP_RESOURCE"
}
variable compartment_name {
  type=string
}
variable idcs_endpoint {
  type=string
  default="https://idcs-f8672d1154fc4232a0b0947ab83a8c8b.uk-london-idcs-1.identity.uk-london-1.oci.oraclecloud.com:443"
}
variable schedule_policy_description {
  type=string
  default="Resource Schedule Times Policies"
}
variable schedule_policy_name {
  type=string
  default="ResourceScheduleTimedPolicy"
}
variable schedule_group_name {
  type=string
  default="ResourceScheduleUsers"
}
variable schedule_recurrence_details {
  type=string
  default="FREQ=DAILY;INTERVAL=1"
}
variable schedule_recurrence_type {
  type=string
  default="ICAL"
}
variable schedule_description {
  type=string
  default="Resource Schedule"
}
variable schedule_display_name {
  type=string
  default="ResourceSchedule"
}
variable schedule_resources_id {
  type=string
  default=""
}
variable stop_times {
  type=list(string)
}
variable start_times {
  type=list(string)
}
variable schedule_resource_filters_attribute {
  type=string
  default="DEFINED_TAGS"
}
variable schedule_resource_filters_condition {
  type=string
  default="="
}
variable schedule_resource_filters_should_include_child_compartments {
  type=string
}
variable schedule_resource_filters_value_namespace {
  type=string
}
variable schedule_resource_filters_value_tag_key_start {
  type=string
}
variable schedule_resource_filters_value_tag_key_stop {
  type=string
}
