# Copyright (c) 2020 Oracle and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.

data "oci_core_vcns" "vcns" {

  compartment_id = var.compartment_id
  display_name   = var.vcn_name
}

/* data "oci_core_subnets" "subnets" {
  #Required
  compartment_id  = var.compartment_id

  #Optional
  display_name    = var.subnet_name
} */

data "oci_core_drgs" "drgs" {
  #Required
  compartment_id = var.compartment_id
}

data "oci_core_security_lists" "sec_lists" {
    #Required
    compartment_id = var.compartment_id

    #Optional
    display_name  = var.security_list_display_name
    vcn_id        = data.oci_core_vcns.vcns.virtual_networks[0].id
}