data "oci_database_autonomous_databases" "source_autonomous_databases" {
  compartment_id           = local.source_compartment_id
  display_name             = var.source_database_name
}

locals {
  source_database_id       = data.oci_database_autonomous_databases.source_autonomous_databases.autonomous_databases[0].id
}
