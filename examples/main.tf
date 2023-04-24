module "vcn" {
  source = "git::ssh://devops.scmservice.us-ashburn-1.oci.oraclecloud.com/namespaces/id9de6bj2yv6/projects/claro-devops/repositories/terraform-oci-network?ref=v0.1.3"

  for_each = var.vcns

  # general oci parameters
  compartment_id = data.oci_identity_compartments.network_cmp[each.key].compartments[0].id
  label_prefix   = lookup(each.value, "label_prefix", "none")
  defined_tags   = lookup(each.value, "defined_tags", {})
  freeform_tags  = lookup(each.value, "freeform_tags", {})

  # vcn parameters
  lockdown_default_seclist = lookup(each.value, "lockdown_default_seclist", false) # boolean: true or false
  enable_ipv6              = lookup(each.value, "enable_ipv6", false)              # boolean: true or false
  vcn_cidrs                = each.value["cidrs"]                                   # List of IPv4 CIDRs
  vcn_dns_label            = each.value["dns_label"]                               # string
  vcn_name                 = each.key                                              # string

  # gateways parameters
  create_internet_gateway       = lookup(each.value, "create_internet_gateway", false) # boolean: true or false
  internet_gateway_display_name = lookup(each.value, "internet_gateway_display_name", "internet-gateway")

  create_nat_gateway       = lookup(each.value, "create_nat_gateway", false) # boolean: true or false
  nat_gateway_display_name = lookup(each.value, "nat_gateway_display_name", "nat-gateway")

  create_service_gateway       = lookup(each.value, "create_service_gateway", false) # boolean: true or false
  service_gateway_display_name = lookup(each.value, "service_gateway_display_name", "service-gateway")

}