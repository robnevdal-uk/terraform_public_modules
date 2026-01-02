data "oci_core_subnet" "instance_subnet" {
  count                            = length(var.subnet_ocids)
  subnet_id                        = element(var.subnet_ocids, count.index)
}

data "oci_identity_availability_domains" "ad" {
  compartment_id                   = local.compartment_id
}

locals {
  ADs = [
    for i in data.oci_identity_availability_domains.ad.availability_domains : i.name
  ]
  FDs = [
    for i in data.oci_identity_fault_domains.fd.fault_domains : i.name
  ]
}

data "oci_identity_fault_domains" "fd" {
  compartment_id                   = local.compartment_id
  availability_domain              =  var.ad_number == null ? element(local.ADs, 1) : element(local.ADs, var.ad_number - 1)
}

data "oci_core_network_security_groups" "nsg" {
  compartment_id                   = local.nsg_compartment_id
}

locals {
  all_nsgs                         = { for i in data.oci_core_network_security_groups.nsg.network_security_groups : i.display_name => i.id }
  nsg_ids                          = [ for k in var.nsg_names : lookup(local.all_nsgs,k) ]
}

data "oci_core_images" "image" {
  compartment_id                   = local.image_compartment_id
  display_name                     = var.source_image_name  
}

#data "oci_identity_compartments" "vault_compartment" {
  #compartment_id                   = var.tenancy_ocid
  #name                             = "Key-Admin"
#}

#data "oci_vault_secrets" "secrets" {
  #compartment_id                   = data.oci_identity_compartments.vault_compartment.compartments[0].id
  #name                             = var.secret_name_of_key
#}

#data "oci_secrets_secretbundle" "secretbundle" {
  #secret_id                        = data.oci_vault_secrets.secrets.secrets[0].id
#}

resource "oci_core_instance" "compute_instance" {
  availability_domain              = var.ad_number == null ? element(local.ADs, 1) : element(local.ADs, var.ad_number - 1)
  fault_domain                     = var.fd_number == null ? element(local.FDs, 1) : element(local.FDs, var.fd_number - 1)
  compartment_id                   = local.compartment_id
  display_name                     = var.instance_display_name
  source_details {
    source_id                      = data.oci_core_images.image.images[0].id
    source_type                    = var.source_type
    boot_volume_size_in_gbs        = var.boot_storage_sizes_in_gbs
    kms_key_id                     = var.kms_key_id
  }
  shape                            = var.shape
  shape_config {
    memory_in_gbs                  = var.memory_in_gbs
    ocpus                          = var.number_of_cpus
  }
  state                            = var.instance_state
  create_vnic_details {
    private_ip                     = var.private_ip
    assign_public_ip               = "false"
    subnet_id                      = data.oci_core_subnet.instance_subnet[1 % length(data.oci_core_subnet.instance_subnet.*.id)].id
    nsg_ids                        = local.nsg_ids
  }
  metadata = {
    #ssh_authorized_keys           = base64decode(data.oci_secrets_secretbundle.secretbundle.secret_bundle_content[0].content)
    ssh_authorized_keys            = var.ssh_authorized_keys
    #user_data                     = var.cloud_init_script == null ? "" : "${base64encode(file(var.cloud_init_script))}"
  }
  #platform_config {
    #type                           = var.platform_config_type
    #is_secure_boot_enabled         = var.is_secure_boot_enabled
  #}
  agent_config {
    is_monitoring_disabled         = var.is_monitoring_disabled
    is_management_disabled         = var.is_management_disabled
    are_all_plugins_disabled       = var.are_all_plugins_disabled
    plugins_config {
      desired_state                = var.plugin_weblogic_management_service
      name                         = "WebLogic Management Service"
    }
    plugins_config {
      desired_state                = var.plugin_vulnerability_scanning
      name                         = "Vulnerability Scanning"
    }
    plugins_config {
      desired_state                = var.plugin_java_management_service
      name                         = "Oracle Java Management Service"
    }
    plugins_config {
      desired_state                = var.plugin_os_management_service_agent
      name                         = "OS Management Service Agent"
    }
    plugins_config {
      desired_state                = var.plugin_flee_app_management_service
      name                         = "OS Management Hub Agent"
    }
    plugins_config {
      desired_state                = var.plugin_management_agent
      name                         = "Management Agent"
    }
    plugins_config {
      desired_state                = var.plugin_custom_logs_monitoring
      name                         = "Custom Logs Monitoring"
    }
    plugins_config {
      desired_state                = var.plugin_compute_rdma_gpu_monitoring
      name                         = "Compute RDMA GPU Monitoring"
    }
    plugins_config {
      desired_state                = var.plugin_compute_instance_run_command
      name                         = "Compute Instance Run Command"
    }
    plugins_config {
      desired_state                = var.plugin_compute_instance_monitoring
      name                         = "Compute Instance Monitoring"
    }
    plugins_config {
      desired_state                = var.plugin_hpc_rdma_autoconfig
      name                         = "Compute HPC RDMA Auto-Configuration"
    }
    plugins_config {
      desired_state                = var.plugin_hpc_rdma_auth
      name                         = "Compute HPC RDMA Authentication"
    }
    plugins_config {
      desired_state                = var.plugin_CG_workload_protection
      name                         = "Cloud Guard Workload Protection"
    }
    plugins_config {
      desired_state                = var.plugin_block_volume_management
      name                         = "Block Volume Management"
    }
    plugins_config {
      desired_state                = var.plugin_bastion
      name                         = "Bastion"
    }
  }
  lifecycle {
    ignore_changes = [
      defined_tags["Oracle-Tags CreatedBy"],
      defined_tags["Oracle-Tags CreatedOn"],
      source_details,
      metadata["user_data"],
      metadata["ssh_authorized_keys"]
    ]
  }
}

resource "oci_core_volume" "compute_block_volume" {
  for_each = var.block_volumes
  availability_domain  = var.ad_number == null ? element(local.ADs, 0) : element(local.ADs, var.ad_number - 1)
  defined_tags         = {}
  compartment_id       = local.compartment_id
  display_name         = each.value.volume_name
  kms_key_id           = var.kms_key_id
  size_in_gbs          = each.value.volume_size_in_gbs
  vpus_per_gb          = each.value.vpus_per_gb
  lifecycle {
    ignore_changes = [
      defined_tags["Oracle-Tags CreatedBy"],
      defined_tags["Oracle-Tags CreatedOn"]
    ]
  }
}

resource "oci_core_volume_attachment" "compute_instance_attachment" {
  for_each = var.block_volumes
  attachment_type                     = each.value.block_volume_attachment_attachment_type
  instance_id                         = oci_core_instance.compute_instance.id
  volume_id                           = oci_core_volume.compute_block_volume[each.key].id
  display_name                        = each.value.block_volume_attachment_display_name
  is_agent_auto_iscsi_login_enabled   = each.value.block_volume_attachment_is_agent_auto_iscsi_login_enabled
  is_pv_encryption_in_transit_enabled = each.value.block_volume_attachment_is_pv_encryption_in_transit_enabled
  is_read_only                        = each.value.block_volume_attachment_is_read_only
  is_shareable                        = each.value.block_volume_attachment_is_shareable
  use_chap                            = each.value.block_volume_attachment_use_chap
  lifecycle {
    ignore_changes = [
      is_pv_encryption_in_transit_enabled,
      use_chap
    ]
  }
}
