resource "oci_database_autonomous_database" "autonomous_database" {
  admin_password                                     = var.admin_password
  compartment_id                                     = local.compartment_id
  source                                             = "DATABASE"
  source_id                                          = local.source_database_id
  clone_type                                         = "FULL"
  compute_count                                      = var.compute_count
  compute_model                                      = var.compute_model
  cpu_core_count                                     = var.cpu_core_count
  dynamic "customer_contacts" {
    for_each                                         = var.customer_contacts_emails
    content {
      email                                          = customer_contacts.value
    }
  }
  data_storage_size_in_gb                            = var.data_storage_size_in_gb
  db_name                                            = var.db_name
  display_name                                       = var.display_name
  in_memory_percentage                               = var.in_memory_percentage
  is_auto_scaling_enabled                            = var.is_auto_scaling_enabled
  is_auto_scaling_for_storage_enabled                = var.is_auto_scaling_for_storage_enabled
  max_cpu_core_count                                 = var.max_cpu_core_count
  nsg_ids                                            = var.nsg_ids
  ocpu_count                                         = var.ocpu_count
  private_endpoint_label                             = var.private_endpoint_label
  subnet_id                                          = local.subnet_id
}
