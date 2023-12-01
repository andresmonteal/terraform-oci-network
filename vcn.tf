# Copyright (c) 2019, 2021, Oracle Corporation and/or affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl/

resource "oci_core_vcn" "vcn" {
  # We still allow module users to declare a cidr using `vcn_cidr` instead of the now recommended `vcn_cidrs`, but internally we map both to `cidr_blocks`
  # The module always use the new list of string structure and let the customer update his module definition block at his own pace.
  cidr_blocks    = var.vcn_cidrs[*]
  compartment_id = local.compartment_id
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
  source   = "git@github.com:andresmonteal/terraform-oci-network-subnet.git?ref=v0.2.13"
  for_each = var.subnets

  # subnet
  compartment_id = local.compartment_id
  cidr_block     = each.value["cidr_block"]
  vcn_id         = oci_core_vcn.vcn.id

  # optional
  display_name     = each.key
  dns_label        = each.value["dns_label"]
  type             = each.value["type"]

  # tags
  freeform_tags = local.merged_freeform_tags
  defined_tags  = each.value["defined_tags"]

  # route table
  route_table = lookup(each.value, "route_table", null)
}

module "drg_route_table" {
  source = "git@github.com:andresmonteal/terraform-oci-route-table.git?ref=v0.5.4"
  
  for_each = var.drg_route_table

  display_name   = each.key
  compartment_id = local.compartment_id
  vcn_id         = oci_core_vcn.vcn.id
  defined_tags   = var.defined_tags
  freeform_tags  = local.merged_freeform_tags

  rules = can(each.value["rules"]) ? each.value["rules"] : {}
}

resource "oci_core_drg_attachment" "main" {
  for_each = var.drg_route_table
  #Required
  drg_id = local.drg_id

  #Optional
  defined_tags  = var.defined_tags
  display_name  = coalesce(var.drg_att_name,"att-${var.drg_name}-${var.vcn_name}")
  freeform_tags = local.merged_freeform_tags
  network_details {
    #Required
    id   = oci_core_vcn.vcn.id
    type = "VCN"

    #Optional
    route_table_id = module.drg_route_table[each.key].id
    vcn_route_type = "VCN_CIDRS"
  }
}