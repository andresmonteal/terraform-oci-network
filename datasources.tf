data "oci_identity_compartments" "network_cmp" {
  count = var.tenancy_ocid == null ? 0 : 1
  #Required
  compartment_id            = var.tenancy_ocid
  access_level              = "ANY"
  compartment_id_in_subtree = true

  #Optional
  filter {
    name   = "state"
    values = ["ACTIVE"]
  }

  filter {
    name   = "name"
    values = [var.compartment]
  }
}

data "oci_core_drgs" "drg" {
  count = var.tenancy_ocid == null ? 0 : 1
  #Required
  compartment_id = local.compartment_id

  filter {
    name   = "display_name"
    values = [var.drg_name]
  }
}