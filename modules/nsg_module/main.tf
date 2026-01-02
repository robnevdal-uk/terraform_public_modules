data "oci_core_services" "service_gw" {
  filter {
    name   = "name"
    values = ["All .* Services In Oracle Services Network"]
    regex  = true
  }
}

data "oci_core_network_security_groups" "existing_nsgs" {
  vcn_id                         = var.vcn_id
  compartment_id                 = local.compartment_id
}

locals {
  remote_nsg_ids                 = { for i in data.oci_core_network_security_groups.existing_nsgs.network_security_groups : i.display_name => i.id }
}

resource "oci_core_network_security_group" "oci_nsg" {
  vcn_id                         = var.vcn_id
  compartment_id                 = local.compartment_id
  display_name                   = var.nsg_display_name
}

resource "oci_core_network_security_group_security_rule" "oci_nsg_ingress_rule_service" {
  depends_on                 = [ oci_core_network_security_group.oci_nsg ]
  for_each = { for k, v in var.oci_nsg_ingress_rule: k => v if v.ingress_rule_source_type == "SERVICE_CIDR_BLOCK"}
  network_security_group_id  = oci_core_network_security_group.oci_nsg.id
  direction                  = "INGRESS"
  description                = each.value["ingress_rule_description"]
  stateless                  = each.value["ingress_rule_stateless"]
  protocol                   = "all"
  source                     = data.oci_core_services.service_gw.services[0].cidr_block
  source_type                = each.value["ingress_rule_source_type"]
}
resource "oci_core_network_security_group_security_rule" "oci_nsg_ingress_rule_all" {
  depends_on                 = [ oci_core_network_security_group.oci_nsg ]
  for_each = { for k, v in var.oci_nsg_ingress_rule: k => v if v.ingress_rule_source_min == null && v.ingress_rule_destination_min == null && upper(v.ingress_rule_protocol) == "ALL"}
  network_security_group_id  = oci_core_network_security_group.oci_nsg.id
  direction                  = "INGRESS"
  description                = each.value["ingress_rule_description"]
  stateless                  = each.value["ingress_rule_stateless"]
  protocol                   = "all"
  source                     = (each.value["ingress_rule_source_type"] == "NETWORK_SECURITY_GROUP" ? each.value["ingress_rule_source"] : each.value["ingress_rule_source"])
  source_type                = each.value["ingress_rule_source_type"]
}
resource "oci_core_network_security_group_security_rule" "oci_nsg_ingress_rule_all_source" {
  depends_on                 = [ oci_core_network_security_group.oci_nsg ]
  for_each = { for k, v in var.oci_nsg_ingress_rule: k => v if v.ingress_rule_source_min != null && v.ingress_rule_destination_min == null && upper(v.ingress_rule_protocol) == "ALL"}
  network_security_group_id  = oci_core_network_security_group.oci_nsg.id
  direction                  = "INGRESS"
  description                = each.value["ingress_rule_description"]
  stateless                  = each.value["ingress_rule_stateless"]
  protocol                   = "all"
  source                     = (each.value["ingress_rule_source_type"] == "NETWORK_SECURITY_GROUP" ? each.value["ingress_rule_source"] : each.value["ingress_rule_source"])
  source_type                = each.value["ingress_rule_source_type"]
  tcp_options {
    source_port_range {
      min                    = each.value["ingress_rule_source_min"]
      max                    = each.value["ingress_rule_source_max"]
    }
  }
}
resource "oci_core_network_security_group_security_rule" "oci_nsg_ingress_rule_all_destination" {
  depends_on                 = [ oci_core_network_security_group.oci_nsg ]
  for_each = { for k, v in var.oci_nsg_ingress_rule: k => v if v.ingress_rule_source_min == null && v.ingress_rule_destination_min != null && upper(v.ingress_rule_protocol) == "ALL"}
  network_security_group_id  = oci_core_network_security_group.oci_nsg.id
  direction                  = "INGRESS"
  description                = each.value["ingress_rule_description"]
  stateless                  = each.value["ingress_rule_stateless"]
  protocol                   = "all"
  source                     = (each.value["ingress_rule_source_type"] == "NETWORK_SECURITY_GROUP" ? each.value["ingress_rule_source"] : each.value["ingress_rule_source"])
  source_type                = each.value["ingress_rule_source_type"]
  tcp_options {
    destination_port_range {
      min                    = each.value["ingress_rule_destination_min"]
      max                    = each.value["ingress_rule_destination_max"]
    }
  }
}
resource "oci_core_network_security_group_security_rule" "oci_nsg_ingress_rule_all_source_destination" {
  depends_on                 = [ oci_core_network_security_group.oci_nsg ]
  for_each = { for k, v in var.oci_nsg_ingress_rule: k => v if v.ingress_rule_source_min != null && v.ingress_rule_destination_min != null && upper(v.ingress_rule_protocol) == "ALL"}
  network_security_group_id  = oci_core_network_security_group.oci_nsg.id
  direction                  = "INGRESS"
  description                = each.value["ingress_rule_description"]
  stateless                  = each.value["ingress_rule_stateless"]
  protocol                   = "all"
  source                     = (each.value["ingress_rule_source_type"] == "NETWORK_SECURITY_GROUP" ? each.value["ingress_rule_source"] : each.value["ingress_rule_source"])
  source_type                = each.value["ingress_rule_source_type"]
  tcp_options {
    source_port_range {
      min                    = each.value["ingress_rule_source_min"]
      max                    = each.value["ingress_rule_source_max"]
    }
    destination_port_range {
      min                    = each.value["ingress_rule_destination_min"]
      max                    = each.value["ingress_rule_destination_max"]
    }
  }
}
resource "oci_core_network_security_group_security_rule" "oci_nsg_ingress_rule_tcp_all" {
  depends_on                 = [ oci_core_network_security_group.oci_nsg ]
  for_each = { for k, v in var.oci_nsg_ingress_rule: k => v if v.ingress_rule_source_min == null && v.ingress_rule_destination_min == null && v.ingress_rule_protocol == "TCP"}
  network_security_group_id  = oci_core_network_security_group.oci_nsg.id
  direction                  = "INGRESS"
  description                = each.value["ingress_rule_description"]
  stateless                  = each.value["ingress_rule_stateless"]
  protocol                   = "6"
  source                     = (each.value["ingress_rule_source_type"] == "NETWORK_SECURITY_GROUP" ? each.value["ingress_rule_source"] : each.value["ingress_rule_source"])
  source_type                = each.value["ingress_rule_source_type"]
}
resource "oci_core_network_security_group_security_rule" "oci_nsg_ingress_rule_tcp_source" {
  depends_on                 = [ oci_core_network_security_group.oci_nsg ]
  for_each = { for k, v in var.oci_nsg_ingress_rule: k => v if v.ingress_rule_source_min != null && v.ingress_rule_destination_min == null && v.ingress_rule_protocol == "TCP"}
  network_security_group_id  = oci_core_network_security_group.oci_nsg.id
  direction                  = "INGRESS"
  description                = each.value["ingress_rule_description"]
  stateless                  = each.value["ingress_rule_stateless"]
  protocol                   = "6"
  source                     = (each.value["ingress_rule_source_type"] == "NETWORK_SECURITY_GROUP" ? each.value["ingress_rule_source"] : each.value["ingress_rule_source"])
  source_type                = each.value["ingress_rule_source_type"]
  tcp_options {
    source_port_range {
      min                    = each.value["ingress_rule_source_min"]
      max                    = each.value["ingress_rule_source_max"]
    }
  }
}
resource "oci_core_network_security_group_security_rule" "oci_nsg_ingress_rule_tcp_destination" {
  for_each = { for k, v in var.oci_nsg_ingress_rule: k => v if v.ingress_rule_source_min == null && v.ingress_rule_destination_min != null && v.ingress_rule_protocol == "TCP"}
  network_security_group_id  = oci_core_network_security_group.oci_nsg.id
  direction                  = "INGRESS"
  description                = each.value["ingress_rule_description"]
  stateless                  = each.value["ingress_rule_stateless"]
  protocol                   = "6"
  source                     = (each.value["ingress_rule_source_type"] == "NETWORK_SECURITY_GROUP" ? each.value["ingress_rule_source"] : each.value["ingress_rule_source"])
  source_type                = each.value["ingress_rule_source_type"]
  tcp_options {
    destination_port_range {
      min                    = each.value["ingress_rule_destination_min"]
      max                    = each.value["ingress_rule_destination_max"]
    }
  }
}
resource "oci_core_network_security_group_security_rule" "oci_nsg_ingress_rule_tcp_source_destination" {
  for_each = { for k, v in var.oci_nsg_ingress_rule: k => v if v.ingress_rule_source_min != null && v.ingress_rule_destination_min != null && v.ingress_rule_protocol == "TCP"}
  network_security_group_id  = oci_core_network_security_group.oci_nsg.id
  direction                  = "INGRESS"
  description                = each.value["ingress_rule_description"]
  stateless                  = each.value["ingress_rule_stateless"]
  protocol                   = "6"
  source                     = (each.value["ingress_rule_source_type"] == "NETWORK_SECURITY_GROUP" ? each.value["ingress_rule_source"] : each.value["ingress_rule_source"])
  source_type                = each.value["ingress_rule_source_type"]
  tcp_options {
    source_port_range {
      min                    = each.value["ingress_rule_source_min"]
      max                    = each.value["ingress_rule_source_max"]
    }
    destination_port_range {
      min                    = each.value["ingress_rule_destination_min"]
      max                    = each.value["ingress_rule_destination_max"]
    }
  }
}
resource "oci_core_network_security_group_security_rule" "oci_nsg_ingress_rule_udp_all" {
  for_each = { for k, v in var.oci_nsg_ingress_rule: k => v if v.ingress_rule_source_min == null && v.ingress_rule_destination_min == null && v.ingress_rule_protocol == "UDP"}
  network_security_group_id  = oci_core_network_security_group.oci_nsg.id
  direction                  = "INGRESS"
  description                = each.value["ingress_rule_description"]
  stateless                  = each.value["ingress_rule_stateless"]
  protocol                   = "17"
  source                     = (each.value["ingress_rule_source_type"] == "NETWORK_SECURITY_GROUP" ? each.value["ingress_rule_source"] : each.value["ingress_rule_source"])
  source_type                = each.value["ingress_rule_source_type"]
}
resource "oci_core_network_security_group_security_rule" "oci_nsg_ingress_rule_udp_source" {
  for_each = { for k, v in var.oci_nsg_ingress_rule: k => v if v.ingress_rule_source_min != null && v.ingress_rule_destination_min == null && v.ingress_rule_protocol == "UDP"}
  network_security_group_id  = oci_core_network_security_group.oci_nsg.id
  direction                  = "INGRESS"
  description                = each.value["ingress_rule_description"]
  stateless                  = each.value["ingress_rule_stateless"]
  protocol                   = "17"
  source                     = (each.value["ingress_rule_source_type"] == "NETWORK_SECURITY_GROUP" ? each.value["ingress_rule_source"] : each.value["ingress_rule_source"])
  source_type                = each.value["ingress_rule_source_type"]
  udp_options {
    source_port_range {
      min                    = each.value["ingress_rule_source_min"]
      max                    = each.value["ingress_rule_source_max"]
    }
  }
}
resource "oci_core_network_security_group_security_rule" "oci_nsg_ingress_rule_udp_destination" {
  for_each = { for k, v in var.oci_nsg_ingress_rule: k => v if v.ingress_rule_source_min == null && v.ingress_rule_destination_min != null && v.ingress_rule_protocol == "UDP"}
  network_security_group_id  = oci_core_network_security_group.oci_nsg.id
  direction                  = "INGRESS"
  description                = each.value["ingress_rule_description"]
  stateless                  = each.value["ingress_rule_stateless"]
  protocol                   = "17"
  source                     = (each.value["ingress_rule_source_type"] == "NETWORK_SECURITY_GROUP" ? each.value["ingress_rule_source"] : each.value["ingress_rule_source"])
  source_type                = each.value["ingress_rule_source_type"]
  udp_options {
    destination_port_range {
      min                    = each.value["ingress_rule_destination_min"]
      max                    = each.value["ingress_rule_destination_max"]
    }
  }
}
resource "oci_core_network_security_group_security_rule" "oci_nsg_ingress_rule_udp_source_destination" {
  for_each = { for k, v in var.oci_nsg_ingress_rule: k => v if v.ingress_rule_source_min != null && v.ingress_rule_destination_min != null && v.ingress_rule_protocol == "UDP"}
  network_security_group_id  = oci_core_network_security_group.oci_nsg.id
  direction                  = "INGRESS"
  description                = each.value["ingress_rule_description"]
  stateless                  = each.value["ingress_rule_stateless"]
  protocol                   = "17"
  source                     = (each.value["ingress_rule_source_type"] == "NETWORK_SECURITY_GROUP" ? each.value["ingress_rule_source"] : each.value["ingress_rule_source"])
  source_type                = each.value["ingress_rule_source_type"]
  udp_options {
    source_port_range {
      min                    = each.value["ingress_rule_source_min"]
      max                    = each.value["ingress_rule_source_max"]
    }
    destination_port_range {
      min                    = each.value["ingress_rule_destination_min"]
      max                    = each.value["ingress_rule_destination_max"]
    }
  }
}
resource "oci_core_network_security_group_security_rule" "oci_nsg_ingress_rule_icmp_code" {
  for_each = { for k, v in var.oci_nsg_ingress_rule: k => v if v.ingress_rule_code != null && v.ingress_rule_protocol == "ICMP"}
  network_security_group_id  = oci_core_network_security_group.oci_nsg.id
  direction                  = "INGRESS"
  description                = each.value["ingress_rule_description"]
  stateless                  = each.value["ingress_rule_stateless"]
  protocol                   = "1"
  source                     = (each.value["ingress_rule_source_type"] == "NETWORK_SECURITY_GROUP" ? each.value["ingress_rule_source"] : each.value["ingress_rule_source"])
  source_type                = each.value["ingress_rule_source_type"]
  icmp_options {
    type                     = each.value["ingress_rule_type"]
    code                     = each.value["ingress_rule_code"]
  }
}
resource "oci_core_network_security_group_security_rule" "oci_nsg_ingress_rule_icmp_no_code" {
  for_each = { for k, v in var.oci_nsg_ingress_rule: k => v if v.ingress_rule_code == null && v.ingress_rule_protocol == "ICMP"}
  network_security_group_id  = oci_core_network_security_group.oci_nsg.id
  direction                  = "INGRESS"
  description                = each.value["ingress_rule_description"]
  stateless                  = each.value["ingress_rule_stateless"]
  protocol                   = "1"
  source                     = (each.value["ingress_rule_source_type"] == "NETWORK_SECURITY_GROUP" ? each.value["ingress_rule_source"] : each.value["ingress_rule_source"])
  source_type                = each.value["ingress_rule_source_type"]
  icmp_options {
    type                     = each.value["ingress_rule_type"]
  }
}
resource "oci_core_network_security_group_security_rule" "oci_nsg_egress_rule_service" {
  for_each = { for k, v in var.oci_nsg_egress_rule: k => v if v.egress_rule_destination_type == "SERVICE_CIDR_BLOCK" }
  network_security_group_id  = oci_core_network_security_group.oci_nsg.id
  direction                  = "EGRESS"
  description                = each.value["egress_rule_description"]
  stateless                  = each.value["egress_rule_stateless"]
  protocol                   = "all"
  destination                = data.oci_core_services.service_gw.services[0].cidr_block
  destination_type           = each.value["egress_rule_destination_type"]
}
resource "oci_core_network_security_group_security_rule" "oci_nsg_egress_rule_all" {
  depends_on                 = [ oci_core_network_security_group.oci_nsg ]
  for_each = { for k, v in var.oci_nsg_egress_rule: k => v if v.egress_rule_source_min == null && v.egress_rule_destination_min == null && upper(v.egress_rule_protocol) == "ALL"}
  network_security_group_id  = oci_core_network_security_group.oci_nsg.id
  direction                  = "INGRESS"
  description                = each.value["egress_rule_description"]
  stateless                  = each.value["egress_rule_stateless"]
  protocol                   = "all"
  destination                = (each.value["egress_rule_destination_type"] == "NETWORK_SECURITY_GROUP" ? each.value["egress_rule_destination"] : each.value["egress_rule_destination"])
  destination_type           = each.value["egress_rule_destination_type"]
}
resource "oci_core_network_security_group_security_rule" "oci_nsg_egress_rule_all_source" {
  depends_on                 = [ oci_core_network_security_group.oci_nsg ]
  for_each = { for k, v in var.oci_nsg_egress_rule: k => v if v.egress_rule_source_min != null && v.egress_rule_destination_min == null && upper(v.egress_rule_protocol) == "ALL"}
  network_security_group_id  = oci_core_network_security_group.oci_nsg.id
  direction                  = "INGRESS"
  description                = each.value["egress_rule_description"]
  stateless                  = each.value["egress_rule_stateless"]
  protocol                   = "all"
  destination                = (each.value["egress_rule_destination_type"] == "NETWORK_SECURITY_GROUP" ? each.value["egress_rule_destination"] : each.value["egress_rule_destination"])
  destination_type           = each.value["egress_rule_destination_type"]
  tcp_options {
    source_port_range {
      min                    = each.value["egress_rule_source_min"]
      max                    = each.value["egress_rule_source_max"]
    }
  }
}
resource "oci_core_network_security_group_security_rule" "oci_nsg_egress_rule_all_destination" {
  depends_on                 = [ oci_core_network_security_group.oci_nsg ]
  for_each = { for k, v in var.oci_nsg_egress_rule: k => v if v.egress_rule_source_min == null && v.egress_rule_destination_min != null && upper(v.egress_rule_protocol) == "ALL"}
  network_security_group_id  = oci_core_network_security_group.oci_nsg.id
  direction                  = "INGRESS"
  description                = each.value["egress_rule_description"]
  stateless                  = each.value["egress_rule_stateless"]
  protocol                   = "all"
  destination                = (each.value["egress_rule_destination_type"] == "NETWORK_SECURITY_GROUP" ? each.value["egress_rule_destination"] : each.value["egress_rule_destination"])
  destination_type           = each.value["egress_rule_destination_type"]
  tcp_options {
    destination_port_range {
      min                    = each.value["egress_rule_destination_min"]
      max                    = each.value["egress_rule_destination_max"]
    }
  }
}
resource "oci_core_network_security_group_security_rule" "oci_nsg_egress_rule_all_source_destination" {
  depends_on                 = [ oci_core_network_security_group.oci_nsg ]
  for_each = { for k, v in var.oci_nsg_egress_rule: k => v if v.egress_rule_source_min != null && v.egress_rule_destination_min != null && upper(v.egress_rule_protocol) == "ALL"}
  network_security_group_id  = oci_core_network_security_group.oci_nsg.id
  direction                  = "INGRESS"
  description                = each.value["egress_rule_description"]
  stateless                  = each.value["egress_rule_stateless"]
  protocol                   = "all"
  destination                = (each.value["egress_rule_destination_type"] == "NETWORK_SECURITY_GROUP" ? each.value["egress_rule_destination"] : each.value["egress_rule_destination"])
  destination_type           = each.value["egress_rule_destination_type"]
  tcp_options {
    source_port_range {
      min                    = each.value["egress_rule_source_min"]
      max                    = each.value["egress_rule_source_max"]
    }
    destination_port_range {
      min                    = each.value["egress_rule_destination_min"]
      max                    = each.value["egress_rule_destination_max"]
    }
  }
}
resource "oci_core_network_security_group_security_rule" "oci_nsg_egress_rule_tcp_all" {
  for_each = { for k, v in var.oci_nsg_egress_rule: k => v if v.egress_rule_source_min == null && v.egress_rule_destination_min == null && v.egress_rule_protocol == "TCP" }
  network_security_group_id  = oci_core_network_security_group.oci_nsg.id
  direction                  = "EGRESS"
  description                = each.value["egress_rule_description"]
  stateless                  = each.value["egress_rule_stateless"]
  protocol                   = "6"
  destination                = (each.value["egress_rule_destination_type"] == "NETWORK_SECURITY_GROUP" ? each.value["egress_rule_destination"] : each.value["egress_rule_destination"])
  destination_type           = each.value["egress_rule_destination_type"]
}
resource "oci_core_network_security_group_security_rule" "oci_nsg_egress_rule_tcp_destination" {
  for_each = { for k, v in var.oci_nsg_egress_rule: k => v if v.egress_rule_source_min == null && v.egress_rule_destination_min != null && v.egress_rule_protocol == "TCP" }
  network_security_group_id  = oci_core_network_security_group.oci_nsg.id
  direction                  = "EGRESS"
  description                = each.value["egress_rule_description"]
  stateless                  = each.value["egress_rule_stateless"]
  protocol                   = "6"
  destination                = (each.value["egress_rule_destination_type"] == "NETWORK_SECURITY_GROUP" ? each.value["egress_rule_destination"] : each.value["egress_rule_destination"])
  destination_type           = each.value["egress_rule_destination_type"]
  tcp_options {
    destination_port_range {
      min                    = each.value["egress_rule_destination_min"]
      max                    = each.value["egress_rule_destination_max"]
    }
  }
}
resource "oci_core_network_security_group_security_rule" "oci_nsg_egress_rule_tcp_source" {
  for_each = { for k, v in var.oci_nsg_egress_rule: k => v if v.egress_rule_source_min != null && v.egress_rule_destination_min == null && v.egress_rule_protocol == "TCP" }
  network_security_group_id  = oci_core_network_security_group.oci_nsg.id
  direction                  = "EGRESS"
  description                = each.value["egress_rule_description"]
  stateless                  = each.value["egress_rule_stateless"]
  protocol                   = "6"
  destination                = (each.value["egress_rule_destination_type"] == "NETWORK_SECURITY_GROUP" ? each.value["egress_rule_destination"] : each.value["egress_rule_destination"])
  destination_type           = each.value["egress_rule_destination_type"]
  tcp_options {
    source_port_range {
      min                    = each.value["egress_rule_source_min"]
      max                    = each.value["egress_rule_source_max"]
    }
  }
}
resource "oci_core_network_security_group_security_rule" "oci_nsg_egress_rule_tcp_source_destination" {
  for_each = { for k, v in var.oci_nsg_egress_rule: k => v if v.egress_rule_source_min != null && v.egress_rule_destination_min != null && v.egress_rule_protocol == "TCP" }
  network_security_group_id  = oci_core_network_security_group.oci_nsg.id
  direction                  = "EGRESS"
  description                = each.value["egress_rule_description"]
  stateless                  = each.value["egress_rule_stateless"]
  protocol                   = "6"
  destination                = (each.value["egress_rule_destination_type"] == "NETWORK_SECURITY_GROUP" ? each.value["egress_rule_destination"] : each.value["egress_rule_destination"])
  destination_type           = each.value["egress_rule_destination_type"]
  tcp_options {
    source_port_range {
      min                    = each.value["egress_rule_source_min"]
      max                    = each.value["egress_rule_source_max"]
    }
    destination_port_range {
      min                    = each.value["egress_rule_destination_min"]
      max                    = each.value["egress_rule_destination_max"]
    }
  }
}
resource "oci_core_network_security_group_security_rule" "oci_nsg_egress_rule_udp_all" {
  for_each = { for k, v in var.oci_nsg_egress_rule: k => v if v.egress_rule_source_min == null && v.egress_rule_destination_min == null && v.egress_rule_protocol == "UDP"}
  network_security_group_id  = oci_core_network_security_group.oci_nsg.id
  direction                  = "EGRESS"
  description                = each.value["egress_rule_description"]
  stateless                  = each.value["egress_rule_stateless"]
  protocol                   = "17"
  destination                = (each.value["egress_rule_destination_type"] == "NETWORK_SECURITY_GROUP" ? each.value["egress_rule_destination"] : each.value["egress_rule_destination"])
  destination_type           = each.value["egress_rule_destination_type"]
}
resource "oci_core_network_security_group_security_rule" "oci_nsg_egress_rule_udp_destination" {
  for_each = { for k, v in var.oci_nsg_egress_rule: k => v if v.egress_rule_source_min == null && v.egress_rule_destination_min != null && v.egress_rule_protocol == "UDP"}
  network_security_group_id  = oci_core_network_security_group.oci_nsg.id
  direction                  = "EGRESS"
  description                = each.value["egress_rule_description"]
  stateless                  = each.value["egress_rule_stateless"]
  protocol                   = "17"
  destination                = (each.value["egress_rule_destination_type"] == "NETWORK_SECURITY_GROUP" ? each.value["egress_rule_destination"] : each.value["egress_rule_destination"])
  destination_type           = each.value["egress_rule_destination_type"]
  udp_options {
    destination_port_range {
      min                    = each.value["egress_rule_destination_min"]
      max                    = each.value["egress_rule_destination_max"]
    }
  }
}
resource "oci_core_network_security_group_security_rule" "oci_nsg_egress_rule_udp_source" {
  for_each = { for k, v in var.oci_nsg_egress_rule: k => v if v.egress_rule_source_min != null && v.egress_rule_destination_min == null && v.egress_rule_protocol == "UDP"}
  network_security_group_id  = oci_core_network_security_group.oci_nsg.id
  direction                  = "EGRESS"
  description                = each.value["egress_rule_description"]
  stateless                  = each.value["egress_rule_stateless"]
  protocol                   = "17"
  destination                = (each.value["egress_rule_destination_type"] == "NETWORK_SECURITY_GROUP" ? each.value["egress_rule_destination"] : each.value["egress_rule_destination"])
  destination_type           = each.value["egress_rule_destination_type"]
  udp_options {
    source_port_range {
      min                    = each.value["egress_rule_source_min"]
      max                    = each.value["egress_rule_source_max"]
    }
  }
}
resource "oci_core_network_security_group_security_rule" "oci_nsg_egress_rule_udp_source_destination" {
  for_each = { for k, v in var.oci_nsg_egress_rule: k => v if v.egress_rule_source_min != null && v.egress_rule_destination_min != null && v.egress_rule_protocol == "UDP"}
  network_security_group_id  = oci_core_network_security_group.oci_nsg.id
  direction                  = "EGRESS"
  description                = each.value["egress_rule_description"]
  stateless                  = each.value["egress_rule_stateless"]
  protocol                   = "17"
  destination                = (each.value["egress_rule_destination_type"] == "NETWORK_SECURITY_GROUP" ? each.value["egress_rule_destination"] : each.value["egress_rule_destination"])
  destination_type           = each.value["egress_rule_destination_type"]
  udp_options {
    source_port_range {
      min                    = each.value["egress_rule_source_min"]
      max                    = each.value["egress_rule_source_max"]
    }
    destination_port_range {
      min                    = each.value["egress_rule_destination_min"]
      max                    = each.value["egress_rule_destination_max"]
    }
  }
}
resource "oci_core_network_security_group_security_rule" "oci_nsg_egress_rule_icmp_code" {
  for_each = { for k, v in var.oci_nsg_egress_rule: k => v if v.egress_rule_code != null && v.egress_rule_protocol == "ICMP"}
  network_security_group_id  = oci_core_network_security_group.oci_nsg.id
  direction                  = "EGRESS"
  description                = each.value["egress_rule_description"]
  stateless                  = each.value["egress_rule_stateless"]
  protocol                   = "1"
  destination                = (each.value["egress_rule_destination_type"] == "NETWORK_SECURITY_GROUP" ? each.value["egress_rule_destination"] : each.value["egress_rule_destination"])
  destination_type           = each.value["egress_rule_destination_type"]
  icmp_options {
    type                     = each.value["egress_rule_min"]
    code                     = each.value["egress_rule_max"]
  }
}
resource "oci_core_network_security_group_security_rule" "oci_nsg_egress_rule_icmp_no_code" {
  for_each = { for k, v in var.oci_nsg_egress_rule: k => v if v.egress_rule_code == null && v.egress_rule_protocol == "ICMP"}
  network_security_group_id  = oci_core_network_security_group.oci_nsg.id
  direction                  = "EGRESS"
  description                = each.value["egress_rule_description"]
  stateless                  = each.value["egress_rule_stateless"]
  protocol                   = "1"
  destination                = (each.value["egress_rule_destination_type"] == "NETWORK_SECURITY_GROUP" ? each.value["egress_rule_destination"] : each.value["egress_rule_destination"])
  destination_type           = each.value["egress_rule_destination_type"]
  icmp_options {
    type                     = each.value["egress_rule_type"]
  }
}
