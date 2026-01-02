resource "oci_identity_group" "dev_ods_group" {
  compartment_id                     = var.tenancy_ocid
  description                        = "Data Science Group"
  name                               = var.ods_group_name
}
    
resource "oci_identity_dynamic_group" "dev_ods_dynamic_group" {
  compartment_id                     = var.tenancy_ocid
  description                        = var.ods_dynamic_group_description
  name                               = var.ods_dynamic_group_name
  matching_rule                      = "any {all {resource.type='datasciencenotebooksession',resource.compartment.id='${local.compartment_id}'}, all {resource.type='datasciencejobrun',resource.compartment.id='${local.compartment_id}'}, all {resource.type='datasciencemodeldeployment',resource.compartment.id='${local.compartment_id}'}}"
}
    
resource "oci_identity_policy" "dev_ods_policy" {
  compartment_id                     = var.tenancy_ocid
  description                        = var.ods_policy_description
  name                               = var.ods_policy_name
  statements                         = local.compartment_id == var.tenancy_ocid ? var.enable_vault ? concat(local.ods_root_policies, local.vault_root_policies) : local.ods_root_policies : var.enable_vault ? concat(local.ods_policies, local.vault_policies) : local.ods_policies
}

resource "oci_kms_vault" "dev_ods_vault" {
  count                              = var.enable_vault ? 1 : 0
  compartment_id                     = local.compartment_id
  display_name                       = var.ods_vault_name
  vault_type                         = var.ods_vault_type
}

resource "oci_kms_key" "dev_ods_key" {
  count                              = var.enable_vault ? var.enable_create_vault_master_key ? 1 : 0 : 0
  compartment_id                     = local.compartment_id
  display_name                       = var.ods_vault_master_key_name
  key_shape {
    algorithm                        = "AES"
    length                           = var.ods_vault_master_key_length
  }
  management_endpoint                = oci_kms_vault.dev_ods_vault[0].management_endpoint
}
