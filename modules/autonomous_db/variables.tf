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
variable admin_password {
  type=string
}
variable db_name {
  type=string
}
variable are_primary_whitelisted_ips_used {
  type=bool
  default=false
}
variable auto_refresh_frequency_in_seconds {
  type=number
}
variable auto_refresh_point_lag_in_seconds {
  type=number
}
variable autonomous_maintenance_schedule_type {
  type=string
}
variable backup_retention_period_in_days {
  type=number
}
variable character_set {
  type=string
  default="AL32UTF8"
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
variable data_safe_status {
  type=string
}
variable data_storage_size_in_gb {
  type=string
}
variable database_edition {
  type=string
}
variable db_version {
  type=string
}
variable db_workload {
  type=string
}
variable disaster_recovery_type {
  type=string
}
variable display_name {
  type=string
}
variable in_memory_percentage {
  type=number
}
variable is_access_control_enabled {
  type=bool
  default=false
}
variable is_auto_scaling_enabled {
  type=bool
  default=false
}
variable is_auto_scaling_for_storage_enabled {
  type=bool
  default=false
}
variable is_backup_retention_locked {
  type=bool
  default=false
}
variable is_data_guard_enabled {
  type=string
}
variable is_dedicated {
  type=string
}
variable is_dev_tier {
  type=string
}
variable is_free_tier {
  type=string
}
variable is_local_data_guard_enabled {
  type=string
}
variable is_mtls_connection_required {
  type=string
}
variable is_replicate_automatic_backups {
  type=string
}
variable kms_key_id {
  type=string
}
variable license_model {
  type=string
}
variable max_cpu_core_count {
  type=string
}
variable ncharacter_set {
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
variable resource_pool_summary_is_disabled {
  type=bool
  default=false
}
variable resource_pool_summary_pool_size {
  type=number
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
variable standby_whitelisted_ips {
  type=list(string)
}
variable subnet_id {
  type=string
}
variable subscription_id {
  type=string
}
variable time_of_auto_refresh_start {
  type=string
}
variable timestamp {
  type=string
}
variable whitelisted_ips {
  type=list(string)
}
