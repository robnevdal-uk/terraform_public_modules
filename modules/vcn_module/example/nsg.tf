locals {
  lb_nsg_display_name                  = "Access_for_Public_LB"
  lb_oci_nsg_ingress_rule = {
    rule1 = {
      ingress_rule_description         = "Allow access to Public LB for flexapp01 on port 8010"
      ingress_rule_stateless           = "false"
      ingress_rule_protocol            = "TCP"
      ingress_rule_source              = "208.127.47.192/26"
      ingress_rule_source_type         = "CIDR_BLOCK"
      ingress_rule_source_min          = null
      ingress_rule_source_max          = null
      ingress_rule_destination_min     = "8010"
      ingress_rule_destination_max     = "8010"
      ingress_rule_type                = null
      ingress_rule_code                = null
    }
    rule2 = {
      ingress_rule_description         = "RDP access to 8010"
      ingress_rule_stateless           = "false"
      ingress_rule_protocol            = "TCP"
      ingress_rule_source              = "150.230.114.219/32"
      ingress_rule_source_type         = "CIDR_BLOCK"
      ingress_rule_source_min          = null
      ingress_rule_source_max          = null
      ingress_rule_destination_min     = "8010"
      ingress_rule_destination_max     = "8010"
      ingress_rule_type                = null
      ingress_rule_code                = null
    }
    rule3 = {
      ingress_rule_description         = "Access to flexapp via port 22 - FJ"
      ingress_rule_stateless           = "false"
      ingress_rule_protocol            = "TCP"
      ingress_rule_source              = "208.127.47.192/26"
      ingress_rule_source_type         = "CIDR_BLOCK"
      ingress_rule_source_min          = null
      ingress_rule_source_max          = null
      ingress_rule_destination_min     = "22"
      ingress_rule_destination_max     = "22"
      ingress_rule_type                = null
      ingress_rule_code                = null
    }
    rule4 = {
      ingress_rule_description         = "Access to port 22 for flexapp01 from RDP"
      ingress_rule_stateless           = "false"
      ingress_rule_protocol            = "TCP"
      ingress_rule_source              = "150.230.114.219/32"
      ingress_rule_source_type         = "CIDR_BLOCK"
      ingress_rule_source_min          = null
      ingress_rule_source_max          = null
      ingress_rule_destination_min     = "22"
      ingress_rule_destination_max     = "22"
      ingress_rule_type                = null
      ingress_rule_code                = null
    }
    rule5 = {
      ingress_rule_description         = "Flexpp access for PS"
      ingress_rule_stateless           = "false"
      ingress_rule_protocol            = "TCP"
      ingress_rule_source              = "94.195.250.71/32"
      ingress_rule_source_type         = "CIDR_BLOCK"
      ingress_rule_source_min          = null
      ingress_rule_source_max          = null
      ingress_rule_destination_min     = "22"
      ingress_rule_destination_max     = "22"
      ingress_rule_type                = null
      ingress_rule_code                = null
    }
    rule6 = {
      ingress_rule_description         = "Flexpp access for PS"
      ingress_rule_source              = "94.195.250.71/32"
      ingress_rule_stateless           = "false"
      ingress_rule_protocol            = "TCP"
      ingress_rule_source_type         = "CIDR_BLOCK"
      ingress_rule_source_min          = null
      ingress_rule_source_max          = null
      ingress_rule_destination_min     = "8010"
      ingress_rule_destination_max     = "8010"
      ingress_rule_type                = null
      ingress_rule_code                = null
    }
    rule7 = {
      ingress_rule_description         = "Nelson's IP"
      ingress_rule_stateless           = "false"
      ingress_rule_protocol            = "TCP"
      ingress_rule_source              = "208.127.47.215/32"
      ingress_rule_source_type         = "CIDR_BLOCK"
      ingress_rule_source_min          = null
      ingress_rule_source_max          = null
      ingress_rule_destination_min     = "8010"
      ingress_rule_destination_max     = "8010"
      ingress_rule_type                = null
      ingress_rule_code                = null
    }
    rule8 = {
      ingress_rule_description         = "OP IPs"
      ingress_rule_stateless           = "false"
      ingress_rule_protocol            = "TCP"
      ingress_rule_source              = "208.127.47.192/26"
      ingress_rule_source_type         = "CIDR_BLOCK"
      ingress_rule_source_min          = null
      ingress_rule_source_max          = null
      ingress_rule_destination_min     = "8010"
      ingress_rule_destination_max     = "8010"
      ingress_rule_type                = null
      ingress_rule_code                = null
    }
  }
  lb_oci_nsg_egress_rule               = {}
}

module "LB_NSG" {
  source                               = "../../modules/nsg_module"
  vcn_id                               = module.fj_nw_vcn.id
  nsg_display_name                     = local.lb_nsg_display_name
  compartment_name                     = var.compartment_name
  parent_compartment_name              = var.parent_compartment_name
  duplicate_compartment                = var.duplicate_compartment
  oci_nsg_ingress_rule                 = local.lb_oci_nsg_ingress_rule
  oci_nsg_egress_rule                  = local.lb_oci_nsg_egress_rule
}

locals {
  flexapp_nsg_display_name             = "access flexapp01"
  flexapp_oci_nsg_ingress_rule = {
    rule1 = {
      ingress_rule_description         = ""
      ingress_rule_stateless           = "false"
      ingress_rule_protocol            = "TCP"
      ingress_rule_source              = "208.127.47.192/26"
      ingress_rule_source_type         = "CIDR_BLOCK"
      ingress_rule_source_min          = null
      ingress_rule_source_max          = null
      ingress_rule_destination_min     = "8010"
      ingress_rule_destination_max     = "8010"
      ingress_rule_type                = null
      ingress_rule_code                = null
    }
  }
  flexapp_oci_nsg_egress_rule          = {}
}

module "FLEXAPP_NSG" {
  source                               = "../../modules/nsg_module"
  vcn_id                               = module.fj_nw_vcn.id
  nsg_display_name                     = local.flexapp_nsg_display_name
  compartment_name                     = var.compartment_name
  parent_compartment_name              = var.parent_compartment_name
  duplicate_compartment                = var.duplicate_compartment
  oci_nsg_ingress_rule                 = local.flexapp_oci_nsg_ingress_rule
  oci_nsg_egress_rule                  = local.flexapp_oci_nsg_egress_rule
}

locals {
  adsai_nsg_display_name               = "AccesstoADSFORAI"
  adsai_oci_nsg_ingress_rule           = {
    rule1 = {
      ingress_rule_description         = "Allow access to ADB from within VCN"
      ingress_rule_stateless           = "false"
      ingress_rule_protocol            = "ALL"
      ingress_rule_source              = "0.0.0.0/0"
      ingress_rule_source_type         = "CIDR_BLOCK"
      ingress_rule_source_min          = null
      ingress_rule_source_max          = null
      ingress_rule_destination_min     = null
      ingress_rule_destination_max     = null
      ingress_rule_type                = null
      ingress_rule_code                = null
    }
  }
  adsai_oci_nsg_egress_rule          = {}
}

module "ADSAI_NSG" {
  source                               = "../../modules/nsg_module"
  vcn_id                               = module.fj_nw_vcn.id
  nsg_display_name                     = local.adsai_nsg_display_name
  compartment_name                     = var.compartment_name
  parent_compartment_name              = var.parent_compartment_name
  duplicate_compartment                = var.duplicate_compartment
  oci_nsg_ingress_rule                 = local.adsai_oci_nsg_ingress_rule
  oci_nsg_egress_rule                  = local.adsai_oci_nsg_egress_rule
}

locals {
  oprdp_nsg_display_name               = "External Access to OP RDP computes"
  oprdp_oci_nsg_ingress_rule           = {
    rule1 = {
      ingress_rule_description         = "Allow port 3389 traffic"
      ingress_rule_stateless           = "false"
      ingress_rule_protocol            = "TCP"
      ingress_rule_source              = "208.127.47.192/26"
      ingress_rule_source_type         = "CIDR_BLOCK"
      ingress_rule_source_min          = null
      ingress_rule_source_max          = null
      ingress_rule_destination_min     = "3389"
      ingress_rule_destination_max     = "3389"
      ingress_rule_type                = null
      ingress_rule_code                = null
    }
  }
  oprdp_oci_nsg_egress_rule          = {}
}

module "OPRDP_NSG" {
  source                               = "../../modules/nsg_module"
  vcn_id                               = module.fj_nw_vcn.id
  nsg_display_name                     = local.oprdp_nsg_display_name
  compartment_name                     = var.compartment_name
  parent_compartment_name              = var.parent_compartment_name
  duplicate_compartment                = var.duplicate_compartment
  oci_nsg_ingress_rule                 = local.oprdp_oci_nsg_ingress_rule
  oci_nsg_egress_rule                  = local.oprdp_oci_nsg_egress_rule
}

locals {
  opssh_nsg_display_name               = "External ssh Access to OP computes"
  opssh_oci_nsg_ingress_rule           = {
    rule1 = {
      ingress_rule_description         = "Access from UK SIG range"
      ingress_rule_stateless           = "false"
      ingress_rule_protocol            = "TCP"
      ingress_rule_source              = "208.127.47.192/26"
      ingress_rule_source_type         = "CIDR_BLOCK"
      ingress_rule_source_min          = null
      ingress_rule_source_max          = null
      ingress_rule_destination_min     = "22"
      ingress_rule_destination_max     = "22"
      ingress_rule_type                = null
      ingress_rule_code                = null
    }
  }
  opssh_oci_nsg_egress_rule          = {}
}

module "OPSSH_NSG" {
  source                               = "../../modules/nsg_module"
  vcn_id                               = module.fj_nw_vcn.id
  nsg_display_name                     = local.opssh_nsg_display_name
  compartment_name                     = var.compartment_name
  parent_compartment_name              = var.parent_compartment_name
  duplicate_compartment                = var.duplicate_compartment
  oci_nsg_ingress_rule                 = local.opssh_oci_nsg_ingress_rule
  oci_nsg_egress_rule                  = local.opssh_oci_nsg_egress_rule
}
