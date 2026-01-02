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
variable route_table_name {
  type=string
}
variable vcn_id {
  type=string
}
variable oci_route_table_rule {
  type = map(object({
    description                     = string,
    destination                     = string,
    destination_type                = string,
    network_entity_id               = string
  }))
}
variable oci_route_table_service_rule {
  type = map(object({
    description                     = string,
    network_entity_id               = string
  }))
}
