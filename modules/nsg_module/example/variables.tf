variable tenancy_ocid {
  type=string
  default="ocid1.tenancy.oc1..aaaaaaaag52uodhjagj7zjik5cqlktv7mwlvhxec2ncrn6bodgtbugrdhpta"
}
variable user_ocid {
  type=string
}
variable fingerprint {
  type=string
}
variable private_key_path {
  type=string
}
variable region {
  type=string
}
variable compartment_name {
  type = string
}
variable parent_compartment_name {
  type=string
  default="Tenancy"
}
variable duplicate_compartment {
  type=bool
  default=true
}
