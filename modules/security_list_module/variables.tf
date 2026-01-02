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
variable security_list_name {
  type=string
}
variable vcn_id {
  type=string
}
variable oci_security_list_ingress_rule {
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
variable oci_security_list_egress_rule {
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
