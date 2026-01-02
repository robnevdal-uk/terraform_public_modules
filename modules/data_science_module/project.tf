resource "oci_datascience_project" "dev_project" {
  compartment_id = local.compartment_id
  description    = var.project_description
  display_name   = var.project_display_name
}
