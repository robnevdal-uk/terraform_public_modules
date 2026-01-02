output "id" {
  description = "The OCID of the VCN"
  value       = oci_core_vcn.oci_vcn.id
}

output "default_route_table_id" {
  description = "The OCID of the Default Route Table"
  value       = oci_core_default_route_table.default_route_table.id
}

output "default_security_list_id" {
  description = "The OCID of the Default Security List"
  value       = oci_core_default_security_list.default_security_list.id
}
