resource "oci_datascience_private_endpoint" "dev_data_science_private_endpoint" {
  compartment_id             = local.compartment_id
  data_science_resource_type = var.data_science_private_endpoint_data_science_resource_type
  subnet_id                  = local.subnet_ocids[0]
  description                = var.data_science_private_endpoint_description
  display_name               = var.data_science_private_endpoint_display_name
}
