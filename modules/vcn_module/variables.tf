variable tenancy_ocid {
  type=string
  default="ocid1.tenancy.oc1..aaaaaaaag52uodhjagj7zjik5cqlktv7mwlvhxec2ncrn6bodgtbugrdhpta"
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
variable vcn_display_name {
  type=string
}
variable vcn_dns_label {
  type=string
}
variable vcn_cidr_block {
  type=string
}
variable oci_default_security_list_ingress_rule {
  type = map(object({
    description                     = string,
    stateless                       = string,
    protocol                        = string,
    source                          = string,
    source_type                     = string,
    ingress_rule_min                = string,
    ingress_rule_max                = string,
    ingress_rule_type               = string,
    ingress_rule_code               = string
  }))
}
variable oci_default_security_list_egress_rule {
  type = map(object({
    description                     = string,
    stateless                       = string,
    protocol                        = string,
    destination                     = string,
    destination_type                = string,
    egress_rule_min                 = string,
    egress_rule_max                 = string,
    egress_rule_type                = string,
    egress_rule_code                = string
  }))
}
variable oci_default_route_table_rule {
  type = map(object({
    description                     = string,
    destination                     = string,
    destination_type                = string,
    network_entity_id               = string
  }))
}

variable oci_default_route_table_service_rule {
  type = map(object({
    description                     = string,
    network_entity_id               = string
  }))
}
