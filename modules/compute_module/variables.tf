variable tenancy_ocid {
  type=string
}
variable compartment_name {
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
variable image_compartment_name {
  type=string
}
variable image_parent_compartment_name {
  type=string
  default="Tenancy"
}
variable image_duplicate_compartment {
  type=bool
  default=false
}
variable nsg_compartment_name {
  type=string
}
variable nsg_parent_compartment_name {
  type=string
  default="Tenancy"
}
variable nsg_duplicate_compartment {
  type=bool
  default=false
}
variable instance_count {
  type=string
}
variable ad_number {
  type=string
}
variable fd_number {
  type=string
}
variable instance_display_name {
  type=string
}
variable source_image_name {
  type=string
}
variable subnet_ocids {
  type=list(string)
}
variable subnet_details {
  type = map(object({
    subnet_name             = string
    subnet_compartment_name = string
    parent_compartment_name = string
    duplicate_compartment   = bool
  }))
}
variable private_ip {
  type=string
}
variable public_ip {
  type=string
}
variable secret_name_of_key {
  type=string
}
variable boot_storage_sizes_in_gbs {
  type=string
}
variable memory_in_gbs {
  type=string
}
variable number_of_cpus {
  type=string
}
variable shape {
  type=string
}
variable cloud_init_script {
  type=string
}
variable instance_state {
  type=string
}
variable source_type {
  type=string
}
variable nsg_names {
  type=list(string)
}
variable kms_key_id {
  type=string
  default=null
}
variable ssh_authorized_keys {
  type=string
}
variable platform_config_type {
  type=string
  default="AMD_VM"
}
variable is_secure_boot_enabled{
  type=bool 
  default=false
}
variable is_measured_boot_enabled{
  type=bool 
  default=false
}
variable is_trusted_platform_module_enabled{
  type=bool 
  default=false
}
variable is_monitoring_disabled {
  type=bool 
  default=false
}
variable is_management_disabled {
  type=bool 
  default=false
}
variable are_all_plugins_disabled {
  type=bool 
  default=false
}
variable "block_volumes" {
  type = map(object({
    volume_name                                                 = string
    volume_size_in_gbs                                          = string
    vpus_per_gb                                                 = string
    block_volume_attachment_attachment_type                     = string
    block_volume_attachment_display_name                        = string
    block_volume_attachment_is_agent_auto_iscsi_login_enabled   = string
    block_volume_attachment_is_pv_encryption_in_transit_enabled = string
    block_volume_attachment_is_read_only                        = string
    block_volume_attachment_is_shareable                        = string
    block_volume_attachment_use_chap                            = string
  }))
  description = "Parameters for Block Volumes"
  default     = {}
}
variable overide_start_stop_script {
  type=string 
  default="YES"
}
variable up_24_x_7 {
  type=string 
  default="NO"
}
variable up_weekends {
  type=string 
  default="NO"
}
variable plugin_vulnerability_scanning {
  type=string 
  default="ENABLED"
}
variable plugin_management_agent {
  type=string 
  default="ENABLED"
}
variable plugin_os_management_service_agent {
  type=string 
  default="ENABLED"
}
variable plugin_custom_logs_monitoring {
  type=string 
  default="ENABLED"
}
variable plugin_compute_instance_run_command {
  type=string 
  default="ENABLED"
}
variable plugin_compute_instance_monitoring {
  type=string 
  default="ENABLED"
}
variable plugin_java_management_service {
  type=string 
  default="ENABLED"
}
variable plugin_block_volume_management {
  type=string 
  default="ENABLED"
}
variable plugin_bastion {
  type=string 
  default="ENABLED"
}
variable plugin_hpc_rdma_autoconfig {
  type=string 
  default="ENABLED"
}
variable plugin_hpc_rdma_auth {
  type=string 
  default="ENABLED"
}
variable plugin_CG_workload_protection {
  type=string 
  default="ENABLED"
}
variable plugin_flee_app_management_service {
  type=string 
  default="ENABLED"
}
variable plugin_compute_rdma_gpu_monitoring {
  type=string 
  default="ENABLED"
}
variable plugin_weblogic_management_service {
  type=string 
  default="ENABLED"
}
