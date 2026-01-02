resource "oci_datascience_notebook_session" "dev_notebook_session" {
  compartment_id                              = local.compartment_id
  project_id                                  = oci_datascience_project.dev_project.id
  notebook_session_config_details {
    shape                                     = var.notebook_session_notebook_session_config_details_shape
    block_storage_size_in_gbs                 = var.notebook_session_notebook_session_config_details_block_storage_size_in_gbs
    notebook_session_shape_config_details {
      memory_in_gbs                           = var.notebook_session_notebook_session_config_details_notebook_session_shape_config_details_memory_in_gbs
      ocpus                                   = var.notebook_session_notebook_session_config_details_notebook_session_shape_config_details_ocpus
    }
    private_endpoint_id                       = oci_datascience_private_endpoint.dev_data_science_private_endpoint.id
    subnet_id                                 = local.subnet_ocids[0]
  }
}
