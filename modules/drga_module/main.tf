resource "oci_core_drg_attachment" "drg_attachment" {
  network_details {
    id           = var.vcn_id
    type         = var.vcn_drg_attachment_type
  }
  display_name   = var.vcn_drg_attachment_name
  drg_id         = var.drg_id
}
