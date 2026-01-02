variable tenancy_ocid {
  type=string
}
variable schedule_action {
  type=string
}
variable compartment_name {
  type=string
}
variable dynamic {
  type=number
  default=0
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
}
variable schedule_recurrence_type {
  type=string
}
variable schedule_description {
  type=string
}
variable schedule_display_name {
  type=string
}
variable schedule_resources_id {
  type=string
  default=""
}
variable schedule_time_ends {
  type=string
}
variable schedule_time_starts {
  type=string
}
variable schedule_resource_filters_attribute {
  type=string
  default=""
}
variable schedule_resource_filters_condition {
  type=string
  default=""
}
variable schedule_resource_filters_should_include_child_compartments {
  type=string
  default=""
}
variable schedule_resource_filters_value_namespace {
  type=string
  default=""
}
variable schedule_resource_filters_value_tag_key {
  type=string
  default=""
}
variable schedule_resource_filters_value_value {
  type=string
  default=""
}
