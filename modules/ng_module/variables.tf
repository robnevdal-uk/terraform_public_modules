variable tenancy_ocid {
  type=string
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
variable vcn_id {
  type=string
}
variable nat_gateway_name {
  type=string
}
variable block_traffic_on_gateway {
  type=bool
}
