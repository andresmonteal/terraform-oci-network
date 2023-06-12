module "vcn" {
  source = "../"

  for_each = var.vcns

  # general oci parameters
  tenancy_ocid  = var.tenancy_ocid
  compartment   = each.value["compartment"]
  label_prefix  = lookup(each.value, "label_prefix", "none")
  defined_tags  = lookup(each.value, "defined_tags", {})
  freeform_tags = lookup(each.value, "freeform_tags", {})

  # vcn parameters
  lockdown_default_seclist = lookup(each.value, "lockdown_default_seclist", false) # boolean: true or false
  enable_ipv6              = lookup(each.value, "enable_ipv6", false)              # boolean: true or false
  vcn_cidrs                = each.value["cidrs"]                                   # List of IPv4 CIDRs
  vcn_dns_label            = "${var.region}${each.key}${var.environment}"
  vcn_name                 = "vcn-${var.region}-${each.key}-${var.environment}"

  # gateways parameters
  create_internet_gateway       = lookup(each.value, "create_internet_gateway", false) # boolean: true or false
  internet_gateway_display_name = lookup(each.value, "internet_gateway_display_name", "internet-gateway")

  create_nat_gateway       = lookup(each.value, "create_nat_gateway", false) # boolean: true or false
  nat_gateway_display_name = lookup(each.value, "nat_gateway_display_name", "nat-gateway")

  create_service_gateway       = lookup(each.value, "create_service_gateway", false) # boolean: true or false
  service_gateway_display_name = lookup(each.value, "service_gateway_display_name", "service-gateway")

  # drg parameters
  drg_name = lookup(each.value, "drg_name", null)

}