module "fj_nw_vcn" {
  source                                 = "../../modules/vcn_module"
  compartment_name                       = var.compartment_name
  parent_compartment_name                = var.parent_compartment_name
  duplicate_compartment                  = var.duplicate_compartment
  vcn_display_name                       = var.vcn_display_name
  vcn_dns_label                          = var.vcn_dns_label
  vcn_cidr_block                         = var.vcn_cidr_block
  oci_default_security_list_ingress_rule = local.oci_default_security_list_ingress_rule
  oci_default_security_list_egress_rule  = local.oci_default_security_list_egress_rule
  oci_default_route_table_rule           = local.oci_default_route_table_rule
  oci_default_route_table_service_rule   = local.oci_default_route_table_service_rule
}
