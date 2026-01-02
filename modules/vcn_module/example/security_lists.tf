locals {
  oci_default_security_list_ingress_rule = {
    rule1 = {
      description       = "Example ICMP Ingress Rule"
      stateless         = false
      protocol          = "ICMP"
      source            = "0.0.0.0/0"
      source_type       = "CIDR_BLOCK"
      ingress_rule_min  = null
      ingress_rule_max  = null
      ingress_rule_code = -1
      ingress_rule_type = 3
    }
    rule2 = {
      description       = "Example UDP Ingress Rule"          
      stateless         = false  
      protocol          = "UDP"
      source            = "0.0.0.0/0"
      source_type       = "CIDR_BLOCK" 
      ingress_rule_min  = 111
      ingress_rule_max  = 111 
      ingress_rule_code = null
      ingress_rule_type = null
    }
    rule3 = {
      description       = "Example TCP Ingress Rule"          
      stateless         = false  
      protocol          = "TCP"
      source            = "0.0.0.0/0"
      source_type       = "CIDR_BLOCK" 
      ingress_rule_min  = 22
      ingress_rule_max  = 22 
      ingress_rule_code = null
      ingress_rule_type = null
    }
    rule4 = {
      description       = "Example All Ingress Rule"          
      stateless         = false  
      protocol          = "ALL"
      source            = "0.0.0.0/0"
      source_type       = "CIDR_BLOCK" 
      ingress_rule_min  = null
      ingress_rule_max  = null 
      ingress_rule_code = null
      ingress_rule_type = null
    }
  }
  oci_default_security_list_egress_rule = {
    rule1 = {
      description      = "Example ICMP Egress Rule"
      stateless        = false
      protocol         = "ICMP"
      destination      = "0.0.0.0/0"
      destination_type = "CIDR_BLOCK"
      egress_rule_max  = null
      egress_rule_min  = null
      egress_rule_type = null
      egress_rule_code = null
    }  
    rule2 = {
      description      = "Example UDP Egress Rule"
      stateless        = false
      protocol         = "UDP"
      destination      = "0.0.0.0/0"
      destination_type = "CIDR_BLOCK"
      egress_rule_max = "111"
      egress_rule_min = "111"
      egress_rule_type = null
      egress_rule_code = null
    }  
    rule3 = {
      description      = "Example TCP Egress Rule"
      stateless        = false
      protocol         = "TCP"
      destination      = "0.0.0.0/0"
      destination_type = "CIDR_BLOCK"
      egress_rule_max = "443"
      egress_rule_min = "443"
      egress_rule_type = null
      egress_rule_code = null
    }    
    rule4 = {          
      description      = "Example All Egress Rule"
      stateless        = false
      protocol         = "ALL"
      destination      = "0.0.0.0/0"
      destination_type = "CIDR_BLOCK"
      egress_rule_max  = null
      egress_rule_min  = null
      egress_rule_type = null
      egress_rule_code = null
    }  
  }
}
