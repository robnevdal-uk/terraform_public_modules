variable tenancy_ocid {
  type=string
  default="ocid1.tenancy.oc1..aaaaaaaag52uodhjagj7zjik5cqlktv7mwlvhxec2ncrn6bodgtbugrdhpta"
}
variable vcn_id {
  type = string
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
  type = string
}
variable "subnets" {
  type = map(object({
    subnet_display_name      = string,
    subnet_dns_label         = string,
    private_subnet           = string,
    subnet_cidr_block        = string,
    security_list_id         = list(string),
    route_table_id           = string
  }))
  description                = "Parameters for All Subnets"
  default                    = {}
}
