output "id" {
  description = "The OCID of the Peering Gateway"
  value       = var.peer == true ? oci_core_local_peering_gateway.peering_gateway_peered[0].id : oci_core_local_peering_gateway.peering_gateway_not_peered[0].id
}
