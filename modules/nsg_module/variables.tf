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
variable vcn_id {
  type=string
}
variable compartment_name {
  type=string
}
variable nsg_display_name {
  type=string
}
variable oci_nsg_ingress_rule {
  type = map(object({
    ingress_rule_description         = string,
    ingress_rule_stateless           = string,
    ingress_rule_protocol            = string,
    ingress_rule_source              = string,
    ingress_rule_source_type         = string,
    ingress_rule_source_min          = string,
    ingress_rule_source_max          = string,
    ingress_rule_destination_min     = string,
    ingress_rule_destination_max     = string,
    ingress_rule_type                = string,
    ingress_rule_code                = string
  }))
  description = "Parameters for Ingress Rule"
  default     = {}
}
variable oci_nsg_egress_rule {
  type = map(object({
    egress_rule_description          = string,
    egress_rule_stateless            = string,
    egress_rule_protocol             = string,
    egress_rule_destination          = string,
    egress_rule_destination_type     = string,
    egress_rule_source_min           = string,
    egress_rule_source_max           = string,
    egress_rule_destination_min      = string,
    egress_rule_destination_max      = string,
    egress_rule_type                 = string,
    egress_rule_code                 = string
  }))
  description = "Parameters for TCP Egress Rule"
  default     = {}
}
