locals {
  subnets                       = {for i,v in var.subnets : i => { vcn_id                   = var.vcn_id
                                                                   compartment_id           = local.compartment_id
                                                                   subnet_display_name      = v.subnet_display_name
                                                                   subnet_dns_label         = v.subnet_dns_label
                                                                   private_subnet           = v.private_subnet
                                                                   subnet_cidr_block        = v.subnet_cidr_block
                                                                   security_list_id         = v.security_list_id
                                                                   route_table_id           = v.route_table_id}}

}

resource "oci_core_subnet" "oci_subnet" {
  for_each                      = local.subnets
  vcn_id                        = local.subnets[each.key].vcn_id
  compartment_id                = local.subnets[each.key].compartment_id
  display_name                  = local.subnets[each.key].subnet_display_name
  dns_label                     = local.subnets[each.key].subnet_dns_label
  prohibit_public_ip_on_vnic    = local.subnets[each.key].private_subnet
  cidr_block                    = local.subnets[each.key].subnet_cidr_block
  route_table_id                = local.subnets[each.key].route_table_id
  security_list_ids             = local.subnets[each.key].security_list_id
}
