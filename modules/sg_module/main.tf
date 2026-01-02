data "oci_core_services" "service_gw" {
  filter {
    name   = "name"
    values = ["All .* Services In Oracle Services Network"]
    regex  = true
  }
}

resource "oci_core_service_gateway" "service_gateway" {
  vcn_id         = var.vcn_id
  compartment_id = local.compartment_id
  display_name   = var.service_gateway_name
  services {
    service_id   = data.oci_core_services.service_gw.services[0].id
  }
}
