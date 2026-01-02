resource "oci_identity_tag_namespace" "tag_namespace" {
  compartment_id = local.compartment_id
  description    = var.description
  name           = var.name
}
