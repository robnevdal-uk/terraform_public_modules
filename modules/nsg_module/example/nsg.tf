locals {
  lb_nsg_display_name                  = "<Enter NSG Name>"
  lb_oci_nsg_ingress_rule = {
    rule1 = {
      ingress_rule_description         = "Example TCP Ingress Rule"
      ingress_rule_stateless           = "false"
      ingress_rule_protocol            = "TCP"
      ingress_rule_source              = "0.0.0.0/0"
      ingress_rule_source_type         = "CIDR_BLOCK"
      ingress_rule_source_min          = null
      ingress_rule_source_max          = null
      ingress_rule_destination_min     = "8010"
      ingress_rule_destination_max     = "8010"
      ingress_rule_type                = null
      ingress_rule_code                = null
    }
    rule2 = {
      ingress_rule_description         = "Example All Ingress Rule"
      ingress_rule_stateless           = "false"
      ingress_rule_protocol            = "ALL"
      ingress_rule_source              = "0.0.0.0/0"
      ingress_rule_source_type         = "CIDR_BLOCK"
      ingress_rule_source_min          = null
      ingress_rule_source_max          = null
      ingress_rule_destination_min     = "443"
      ingress_rule_destination_max     = "443"
      ingress_rule_type                = null
      ingress_rule_code                = null
    }
    rule3 = {
      ingress_rule_description         = "Example UDP Ingress Rule"
      ingress_rule_stateless           = "false"
      ingress_rule_protocol            = "UDP"
      ingress_rule_source              = "0.0.0.0/0"
      ingress_rule_source_type         = "CIDR_BLOCK"
      ingress_rule_source_min          = null
      ingress_rule_source_max          = null
      ingress_rule_destination_min     = "443"
      ingress_rule_destination_max     = "443"
      ingress_rule_type                = null
      ingress_rule_code                = null
    }
    rule4 = {
      ingress_rule_description         = "Example ICMP Ingress Rule"
      ingress_rule_stateless           = "false"
      ingress_rule_protocol            = "ICMP"
      ingress_rule_source              = "0.0.0.0/0"
      ingress_rule_source_type         = "CIDR_BLOCK"
      ingress_rule_source_min          = null
      ingress_rule_source_max          = null
      ingress_rule_destination_min     = null
      ingress_rule_destination_max     = null
      ingress_rule_type                = "4"
      ingress_rule_code                = "3"
    }
  }
  lb_oci_nsg_egress_rule               = {
    rule1 = {
      egress_rule_description          = "Example TCP Egress Rule"
      egress_rule_stateless            = "false"
      egress_rule_protocol             = "TCP"
      egress_rule_source               = "0.0.0.0/0"
      egress_rule_source_type          = "CIDR_BLOCK"
      egress_rule_source_min           = null
      egress_rule_source_max           = null
      egress_rule_destination_min      = "8010"
      egress_rule_destination_max      = "8010"
      egress_rule_type                 = null
      egress_rule_code                 = null
    }
    rule2 = {
      egress_rule_description          = "Example All Egress Rule"
      egress_rule_stateless            = "false"
      egress_rule_protocol             = "ALL"
      egress_rule_source               = "0.0.0.0/0"
      egress_rule_source_type          = "CIDR_BLOCK"
      egress_rule_source_min           = null
      egress_rule_source_max           = null
      egress_rule_destination_min      = null
      egress_rule_destination_max      = null
      egress_rule_type                 = null
      egress_rule_code                 = null
    }
    rule3 = {
      egress_rule_description          = "Example UDP Egress Rule"
      egress_rule_stateless            = "false"
      egress_rule_protocol             = "UDP"
      egress_rule_source               = "0.0.0.0/0"
      egress_rule_source_type          = "CIDR_BLOCK"
      egress_rule_source_min           = null
      egress_rule_source_max           = null
      egress_rule_destination_min      = "443"
      egress_rule_destination_max      = "443"
      egress_rule_type                 = null
      egress_rule_code                 = null
    }
    rule4 = {
      egress_rule_description          = "Example ICMP Egress Rule"
      egress_rule_stateless            = "false"
      egress_rule_protocol             = "ICMP"
      egress_rule_source               = "0.0.0.0/0"
      egress_rule_source_type          = "CIDR_BLOCK"
      egress_rule_source_min           = null
      egress_rule_source_max           = null
      egress_rule_destination_min      = null
      egress_rule_destination_max      = null
      egress_rule_type                 = "4"
      egress_rule_code                 = "3"
    }
  }
}

module "NSG" {
  source                               = "../nsg_module"
  vcn_id                               = "<Enter OCID of VCN>"
  nsg_display_name                     = local.lb_nsg_display_name
  compartment_name                     = var.compartment_name
  oci_nsg_ingress_rule                 = local.lb_oci_nsg_ingress_rule
  oci_nsg_egress_rule                  = local.lb_oci_nsg_egress_rule
  # Enter 2 Lines Below if Compartment is not unique
  parent_compartment_name              = "<Enter Parent Compartment Name of Compartment>"
  duplicate_compartment                = "true"
]
