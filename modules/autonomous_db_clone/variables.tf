variable tenancy_ocid {
  type=string
}
variable parent_compartment_name {
  type=string
  default="Tenancy"
}
variable duplicate_compartment {
  type=bool
  default=false
}
variable compartment_name {
  type=string
}
variable source_parent_compartment_name {
  type=string
  default="Tenancy"
}
variable source_duplicate_compartment {
  type=bool
  default=false
}
variable source_compartment_name {
  type=string
}
variable source_database_name {
  type=string
}
variable admin_password {
  type=string
}
variable db_name {
  type=string
}
variable compute_count {
  type=string
}
variable compute_model {
  type=string
}
variable cpu_core_count {
  type=string
}
variable customer_contacts_emails {
  type=list(string)
}
variable data_storage_size_in_gb {
  type=string
}
variable display_name {
  type=string
}
variable in_memory_percentage {
  type=number
}
variable is_auto_scaling_enabled {
  type=bool
  default=false
}
variable is_auto_scaling_for_storage_enabled {
  type=bool
  default=false
}
variable max_cpu_core_count {
  type=string
}
variable nsg_ids {
  type=list(string)
}
variable ocpu_count {
  type=string
}
variable private_endpoint_label {
  type=string
}
variable refreshable_mode {
  type=string
}
variable "scheduled_operations" {
  type = map(object({
    day_of_week_name                 = string,
    start_time                       = string,
    stop_time                        = string,
  }))
  description = "Parameters for Starting and Stopping"
  default     = {}
}
variable subnet_parent_compartment_name {
  type=string
  default="Tenancy"
}
variable subnet_duplicate_compartment {
  type=bool
  default=false
}
variable subnet_compartment_name {
  type=string
}
variable subnet_name {
  type=string
}
variable whitelisted_ips {
  type=list(string)
}
