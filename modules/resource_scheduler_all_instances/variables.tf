variable tenancy_ocid {
  type=string
}
variable compartment_name {
  type=string
}
variable instance_details {
  type = map(object({
    instance_name             = string
    instance_compartment_name = string
    parent_compartment_name   = string
    duplicate_compartment     = bool
    start                     = bool
  }))
}
variable schedule_action_stop {
  type=string
  default="STOP_RESOURCE"
}
variable schedule_action_start {
  type=string
  default="START_RESOURCE"
}
variable schedule_recurrence_details {
  type=string
  default="FREQ=DAILY;INTERVAL=1"
}
variable schedule_recurrence_type {
  type=string
  default="ICAL"
}
variable schedule_time_ends {
  type=string
  default="18:00:00"
}
variable schedule_time_starts {
  type=string
  default="07:00:00"
}
variable schedule_group_description {
  type=string
  default="Resource Schedule Users"
}
variable schedule_group_name {
  type=string
  default="ResourceScheduleUsers"
}
variable schedule_policy_description {
  type=string
  default="Resource Schedule Policies"
}
variable schedule_policy_name {
  type=string
  default="ResourceSchedulePolicy"
}
variable idcs_endpoint {
  type=string
  #default="https://idcs-f8672d1154fc4232a0b0947ab83a8c8b.identity.oraclecloud.com:443"
  default="https://idcs-f8672d1154fc4232a0b0947ab83a8c8b.uk-london-idcs-1.identity.uk-london-1.oci.oraclecloud.com:443"
}
variable schemas {
  type=list(string)
  default = ["urn:ietf:params:scim:schemas:core:2.0:Group", "urn:ietf:params:scim:schemas:oracle:idcs:extension:OCITags", "urn:ietf:params:scim:schemas:oracle:idcs:extension:group:Group"]
}
