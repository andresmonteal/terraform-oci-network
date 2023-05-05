# Copyright (c) 2019, 2021, Oracle Corporation and/or affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl/

locals {
  default_freeform_tags = {
    terraformed = "Please do not edit manually"
    module      = "oracle-terraform-oci-network"
  }
  merged_freeform_tags = merge(var.freeform_tags, local.default_freeform_tags)
}

resource "oci_core_vcn" "vcn" {
  # We still allow module users to declare a cidr using `vcn_cidr` instead of the now recommended `vcn_cidrs`, but internally we map both to `cidr_blocks`
  # The module always use the new list of string structure and let the customer update his module definition block at his own pace.
  cidr_blocks    = var.vcn_cidrs[*]
  compartment_id = var.compartment_id
  display_name   = var.label_prefix == "none" ? var.vcn_name : "${var.label_prefix}-${var.vcn_name}"
  dns_label      = var.vcn_dns_label
  is_ipv6enabled = var.enable_ipv6

  freeform_tags = local.merged_freeform_tags
  defined_tags  = var.defined_tags

  # The timeouts block allows you to specify timeouts for certain operations, 20 minutes is the default value for this resource
  timeouts {
    create = "20m"
    update = "20m"
    delete = "20m"
  }
}

# Module for Subnet
module "subnet" {
  source   = "git@github.com:andresmonteal/terraform-oci-network-subnet.git?ref=v0.1.15"
  for_each = var.subnets

  # subnet
  compartment_id = var.compartment_id
  cidr_block     = each.value["cidr_block"]
  vcn_name       = var.vcn_name

  # optional
  display_name     = each.key
  dns_label        = each.value["dns_label"]
  type             = each.value["type"]
  sec_ls_disp_name = each.value["security_list"]

  # tags
  freeform_tags = local.merged_freeform_tags
  defined_tags  = each.value["defined_tags"]

  # route table
  route_table = lookup(each.value, "route_table", null)
}