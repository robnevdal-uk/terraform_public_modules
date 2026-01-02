locals {
  subnets                      = {
    "example_public_subnet"           = {
      subnet_display_name      = "<Enter Subnet Name>"
      subnet_dns_label         = "<Enter Subnet DNS Label>"
      private_subnet           = false
      subnet_cidr_block        = "<Enter Subnet CIDR Block>"
      security_list_id         = "<Enter OCID of Security List for Subnet>"
      route_table_id           = "<Enter OCID of Route Table for Subnet>"
    }
    "example_public_subnet"           = {
      subnet_display_name      = "<Enter Subnet Name>"
      subnet_dns_label         = "<Enter Subnet DNS Label>"
      private_subnet           = false
      subnet_cidr_block        = "<Enter Subnet CIDR Block>"
      security_list_id         = "<Enter OCID of Security List for Subnet>"
      route_table_id           = "<Enter OCID of Route Table for Subnet>"
    }
  }
}

module "fj_nw_vcn_Subnets" {
  source                   = "../../modules/subnet_module"
  compartment_name         = var.compartment_name
  parent_compartment_name  = var.parent_compartment_name
  duplicate_compartment    = var.duplicate_compartment
  vcn_id                   = "<Enter OCID of VCN>"
  subnets                  = local.subnets
}
