locals {
  ods_policies = [
    "Allow service datascience to use virtual-network-family in tenancy",
    "Allow group ${oci_identity_group.dev_ods_group.name} to read metrics in compartment ${var.parent_compartment_name}",
    "Allow group ${oci_identity_group.dev_ods_group.name} to manage data-science-family in compartment ${var.parent_compartment_name}" ,
    "Allow group ${oci_identity_group.dev_ods_group.name} to manage log-groups in compartment ${var.parent_compartment_name}",
    "Allow group ${oci_identity_group.dev_ods_group.name} to use log-content in compartment ${var.parent_compartment_name}",
    "Allow group ${oci_identity_group.dev_ods_group.name} to use virtual-network-family in tenancy",
    "Allow group ${oci_identity_group.dev_ods_group.name} to use object-family in compartment ${var.parent_compartment_name}",
    "Allow dynamic-group ${oci_identity_dynamic_group.dev_ods_dynamic_group.name} to use log-content in compartment ${var.parent_compartment_name}",
    "Allow dynamic-group ${oci_identity_dynamic_group.dev_ods_dynamic_group.name} to read virtual-network-family in tenancy",
    "Allow dynamic-group ${oci_identity_dynamic_group.dev_ods_dynamic_group.name} to manage data-science-family in compartment ${var.parent_compartment_name}",
    "Allow dynamic-group ${oci_identity_dynamic_group.dev_ods_dynamic_group.name} to use object-family in compartment ${var.parent_compartment_name}",
    "Allow dynamic-group ${oci_identity_dynamic_group.dev_ods_dynamic_group.name} to read repos in compartment ${var.parent_compartment_name}",
    "Allow group ${oci_identity_group.dev_ods_group.name} to use vaults in compartment ${var.parent_compartment_name}",
    "Allow group ${oci_identity_group.dev_ods_group.name} to manage keys in compartment ${var.parent_compartment_name}",
    "Allow dynamic-group ${oci_identity_dynamic_group.dev_ods_dynamic_group.name} to use vaults in compartment ${var.parent_compartment_name}",
    "Allow dynamic-group ${oci_identity_dynamic_group.dev_ods_dynamic_group.name} to manage keys in compartment ${var.parent_compartment_name}"

  ]
  vault_policies = [
    "Allow group ${oci_identity_group.dev_ods_group.name} to use vaults in compartment ${var.parent_compartment_name}",
    "Allow group ${oci_identity_group.dev_ods_group.name} to manage keys in compartment ${var.parent_compartment_name}",
    "Allow dynamic-group ${oci_identity_dynamic_group.dev_ods_dynamic_group.name} to use vaults in compartment ${var.parent_compartment_name}",
    "Allow dynamic-group ${oci_identity_dynamic_group.dev_ods_dynamic_group.name} to manage keys in compartment ${var.parent_compartment_name}"
  ]
  ods_root_policies = [
    "Allow service datascience to use virtual-network-family in tenancy",
    "Allow group ${oci_identity_group.dev_ods_group.name} to read metrics in tenancy",
    "Allow group ${oci_identity_group.dev_ods_group.name} to manage data-science-family in tenancy" ,
    "Allow group ${oci_identity_group.dev_ods_group.name} to manage log-groups in tenancy",
    "Allow group ${oci_identity_group.dev_ods_group.name} to use log-content in tenancy",
    "Allow group ${oci_identity_group.dev_ods_group.name} to use virtual-network-family in tenancy",
    "Allow group ${oci_identity_group.dev_ods_group.name} to use object-family in tenancy",
    "Allow dynamic-group ${oci_identity_dynamic_group.dev_ods_dynamic_group.name} to use log-content in tenancy",
    "Allow dynamic-group ${oci_identity_dynamic_group.dev_ods_dynamic_group.name} to read virtual-network-family in tenancy",
    "Allow dynamic-group ${oci_identity_dynamic_group.dev_ods_dynamic_group.name} to manage data-science-family in tenancy",
    "Allow dynamic-group ${oci_identity_dynamic_group.dev_ods_dynamic_group.name} to use object-family in tenancy",
    "Allow dynamic-group ${oci_identity_dynamic_group.dev_ods_dynamic_group.name} to read repos in tenancy"
  ]
  vault_root_policies = [
    "Allow group ${oci_identity_group.dev_ods_group.name} to use vaults in tenancy",
    "Allow group ${oci_identity_group.dev_ods_group.name} to manage keys in tenancy",
    "Allow dynamic-group ${oci_identity_dynamic_group.dev_ods_dynamic_group.name} to use vaults in tenancy",
    "Allow dynamic-group ${oci_identity_dynamic_group.dev_ods_dynamic_group.name} to manage keys in tenancy"
  ]
}
