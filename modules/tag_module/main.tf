resource "oci_identity_tag" "tag" {
    name               = var.name
    description        = var.description
    tag_namespace_id   = var.tag_namespace_id
    is_cost_tracking   = var.is_cost_tracking
    validator {
        validator_type = var.tag_validator_validator_type
        values         = var.tag_validator_values
    }
}
