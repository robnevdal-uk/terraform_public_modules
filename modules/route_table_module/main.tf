data "oci_core_services" "service_gw" {
  filter {
    name   = "name"
    values = ["All .* Services In Oracle Services Network"]
    regex  = true
  }
}

resource "oci_core_route_table" "route_table" {
  compartment_id               = local.compartment_id
  vcn_id                       = var.vcn_id
  display_name                 = var.route_table_name
  dynamic "route_rules" {
    for_each = var.oci_route_table_rule
    content {
      description              = route_rules.value["description"]
      destination              = route_rules.value["destination"]
      destination_type         = route_rules.value["destination_type"]
      network_entity_id        = route_rules.value["network_entity_id"]
    }
  }
  dynamic "route_rules" {
    for_each = var.oci_route_table_service_rule
    content {
      description              = route_rules.value["description"]
      destination              = "${lookup(data.oci_core_services.service_gw.services[0],"cidr_block")}"
      destination_type         = "SERVICE_CIDR_BLOCK"
      network_entity_id        = route_rules.value["network_entity_id"]
    }
  }
}
