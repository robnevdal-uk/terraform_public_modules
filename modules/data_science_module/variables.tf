variable tenancy_ocid {
  type=string
}
variable region {
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
variable subnet_details {
  type = map(object({
    subnet_name             = string
    subnet_compartment_name = string
    parent_compartment_name = string
    duplicate_compartment   = bool
  }))
}
variable "ods_group_name" {
  type=string
}
variable "ods_dynamic_group_name" {
  type=string
}
variable "ods_dynamic_group_description" {
  type=string
}
variable "ods_policy_name" {
  type=string
}
variable "ods_policy_description" {
  type=string
}
variable "enable_vault" {
  type = bool
}
variable "ods_use_existing_vault" {
  type = bool
}
variable "ods_vault_name" {
  type=string
}
variable "ods_vault_type" {
  type=string
}
variable "enable_create_vault_master_key" {
  type = bool
}
variable "ods_vault_master_key_name" {
  type=string
}
variable "ods_vault_master_key_length" {
  type=string
}
variable "project_description" {
  type=string
}
variable "project_display_name" {
  type=string
}
variable "notebook_session_display_name" {
  type=string
}
variable "notebook_session_notebook_session_config_details_shape" {
  type=string
}
variable "notebook_session_notebook_session_config_details_block_storage_size_in_gbs" {
  type=string
}
variable "notebook_session_notebook_session_config_details_notebook_session_shape_config_details_memory_in_gbs" {
  type=string
}
variable "notebook_session_notebook_session_config_details_notebook_session_shape_config_details_ocpus" {
  type=string
}
variable data_science_private_endpoint_data_science_resource_type {
  type=string
}
variable data_science_private_endpoint_description {
  type=string
}

variable data_science_private_endpoint_display_name {
  type=string
}
