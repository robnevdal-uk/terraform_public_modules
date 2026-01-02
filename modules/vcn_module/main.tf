resource "oci_core_vcn" "oci_vcn" {
  compartment_id               = local.compartment_id
  display_name                 = var.vcn_display_name
  dns_label                    = var.vcn_dns_label
  cidr_block                   = var.vcn_cidr_block
}

resource "oci_core_default_route_table" "default_route_table" {
  manage_default_resource_id   = oci_core_vcn.oci_vcn.default_route_table_id
  compartment_id               = local.compartment_id
  display_name                 = format("Default Route Table for %s", var.vcn_display_name)
  dynamic "route_rules" {
    for_each = var.oci_default_route_table_rule
    content {
      description              = route_rules.value["description"]
      destination              = route_rules.value["destination"]
      destination_type         = route_rules.value["destination_type"]
      network_entity_id        = route_rules.value["network_entity_id"]
    }
  }
  dynamic "route_rules" {
    for_each = var.oci_default_route_table_service_rule
    content {
      description              = route_rules.value["description"]
      destination              = "${lookup(data.oci_core_services.service_gw.services[0],"cidr_block")}"
      destination_type         = "SERVICE_CIDR_BLOCK"
      network_entity_id        = route_rules.value["network_entity_id"]
    }
  }
}

resource "oci_core_default_security_list" "default_security_list" {
  manage_default_resource_id   = oci_core_vcn.oci_vcn.default_security_list_id
  compartment_id               = local.compartment_id
  display_name                 = format("Default Security List for %s", var.vcn_display_name)
  dynamic "ingress_security_rules" {
    for_each = { for k, v in var.oci_default_security_list_ingress_rule: k => v if upper(v.protocol) == "ALL" }
    content {
      description              = ingress_security_rules.value["description"]
      stateless                = ingress_security_rules.value["stateless"]
      protocol                 = lower(ingress_security_rules.value["protocol"])
      source                   = ingress_security_rules.value["source"]
      source_type              = ingress_security_rules.value["source_type"]
    }
  }
  dynamic "ingress_security_rules" {
    for_each = { for k, v in var.oci_default_security_list_ingress_rule: k => v if v.protocol == "TCP" && v.ingress_rule_min == null }
    content {
      description              = ingress_security_rules.value["description"]
      stateless                = ingress_security_rules.value["stateless"]
      protocol                 = "6"
      source                   = ingress_security_rules.value["source"]
      source_type              = ingress_security_rules.value["source_type"]
    }
  }
  dynamic "ingress_security_rules" {
    for_each = { for k, v in var.oci_default_security_list_ingress_rule: k => v if v.protocol == "TCP" && v.ingress_rule_min != null }
    content {
      description              = ingress_security_rules.value["description"]
      stateless                = ingress_security_rules.value["stateless"]
      protocol                 = "6"
      source                   = ingress_security_rules.value["source"]
      source_type              = ingress_security_rules.value["source_type"]
      tcp_options {
        min                    = ingress_security_rules.value["ingress_rule_min"]
        max                    = ingress_security_rules.value["ingress_rule_max"]
      }
    }
  }
  dynamic "ingress_security_rules" {
    for_each = { for k, v in var.oci_default_security_list_ingress_rule: k => v if v.protocol == "UDP"  && v.ingress_rule_min == null }
    content {
      description              = ingress_security_rules.value["description"]
      stateless                = ingress_security_rules.value["stateless"]
      protocol                 = "17"
      source                   = ingress_security_rules.value["source"]
      source_type              = ingress_security_rules.value["source_type"]
    }
  }
  dynamic "ingress_security_rules" {
    for_each = { for k, v in var.oci_default_security_list_ingress_rule: k => v if v.protocol == "UDP"  && v.ingress_rule_min != null }
    content {
      description              = ingress_security_rules.value["description"]
      stateless                = ingress_security_rules.value["stateless"]
      protocol                 = "17"
      source                   = ingress_security_rules.value["source"]
      source_type              = ingress_security_rules.value["source_type"]
      udp_options {
        min                    = ingress_security_rules.value["ingress_rule_min"]
        max                    = ingress_security_rules.value["ingress_rule_max"]
      }
    }
  }
  dynamic "ingress_security_rules" {
    for_each = { for k, v in var.oci_default_security_list_ingress_rule: k => v if v.protocol == "ICMP" && v.ingress_rule_code != null }
    content {
      description              = ingress_security_rules.value["description"]
      stateless                = ingress_security_rules.value["stateless"]
      protocol                 = "1"
      source                   = ingress_security_rules.value["source"]
      source_type              = ingress_security_rules.value["source_type"]
      icmp_options {
        type                   = ingress_security_rules.value["ingress_rule_type"]
        code                   = ingress_security_rules.value["ingress_rule_code"]
      }
    }
  }
  dynamic "ingress_security_rules" {
    for_each = { for k, v in var.oci_default_security_list_ingress_rule: k => v if v.protocol == "ICMP" && v.ingress_rule_code == null }
    content {
      description              = ingress_security_rules.value["description"]
      stateless                = ingress_security_rules.value["stateless"]
      protocol                 = "1"
      source                   = ingress_security_rules.value["source"]
      source_type              = ingress_security_rules.value["source_type"]
      icmp_options {
        type                   = ingress_security_rules.value["ingress_rule_type"]
      }
    }
  }
  dynamic "egress_security_rules" {
    for_each = { for k, v in var.oci_default_security_list_egress_rule: k => v if upper(v.protocol) == "ALL" }
    content {
      description              = egress_security_rules.value["description"]
      stateless                = egress_security_rules.value["stateless"]
      protocol                 = lower(egress_security_rules.value["protocol"])
      destination              = egress_security_rules.value["destination"]
      destination_type         = egress_security_rules.value["destination_type"]
    }
  }
  dynamic "egress_security_rules" {
    for_each = { for k, v in var.oci_default_security_list_egress_rule: k => v if v.protocol == "TCP" && v.egress_rule_min == null }
    content {
      description              = egress_security_rules.value["description"]
      stateless                = egress_security_rules.value["stateless"]
      protocol                 = "6"
      destination              = egress_security_rules.value["destination"]
      destination_type         = egress_security_rules.value["destination_type"]
    }
  }
  dynamic "egress_security_rules" {
    for_each = { for k, v in var.oci_default_security_list_egress_rule: k => v if v.protocol == "TCP" && v.egress_rule_min != null}
    content {
      description              = egress_security_rules.value["description"]
      stateless                = egress_security_rules.value["stateless"]
      protocol                 = "6"
      destination              = egress_security_rules.value["destination"]
      destination_type         = egress_security_rules.value["destination_type"]
      tcp_options {
        min                    = egress_security_rules.value["egress_rule_min"]
        max                    = egress_security_rules.value["egress_rule_max"]
      }
    }
  }
  dynamic "egress_security_rules" {
    for_each = { for k, v in var.oci_default_security_list_egress_rule: k => v if v.protocol == "UDP" && v.egress_rule_min == null }
    content {
      description              = egress_security_rules.value["description"]
      stateless                = egress_security_rules.value["stateless"]
      protocol                 = "17"
      destination              = egress_security_rules.value["destination"]
      destination_type         = egress_security_rules.value["destination_type"]
    }
  }
  dynamic "egress_security_rules" {
    for_each = { for k, v in var.oci_default_security_list_egress_rule: k => v if v.protocol == "UDP" && v.egress_rule_min != null }
    content {
      description              = egress_security_rules.value["description"]
      stateless                = egress_security_rules.value["stateless"]
      protocol                 = "17"
      destination              = egress_security_rules.value["destination"]
      destination_type         = egress_security_rules.value["destination_type"]
      udp_options {
        min                    = egress_security_rules.value["egress_rule_min"]
        max                    = egress_security_rules.value["egress_rule_max"]
      }
    }
  }
  dynamic "egress_security_rules" {
    for_each = { for k, v in var.oci_default_security_list_egress_rule: k => v if v.protocol == "ICMP" && v.egress_rule_code != null }
    content {
      description              = egress_security_rules.value["description"]
      stateless                = egress_security_rules.value["stateless"]
      protocol                 = "1"
      destination              = egress_security_rules.value["destination"]
      destination_type         = egress_security_rules.value["destination_type"]
      icmp_options {
        type                   = egress_security_rules.value["egress_rule_min"]
        code                   = egress_security_rules.value["egress_rule_max"]
      }
    }
  }
  dynamic "egress_security_rules" {
    for_each = { for k, v in var.oci_default_security_list_egress_rule: k => v if v.protocol == "ICMP" && v.egress_rule_code == null }
    content {
      description              = egress_security_rules.value["description"]
      stateless                = egress_security_rules.value["stateless"]
      protocol                 = "1"
      destination              = egress_security_rules.value["destination"]
      destination_type         = egress_security_rules.value["destination_type"]
      icmp_options {
        type                   = egress_security_rules.value["egress_rule_min"]
      }
    }
  }

}
