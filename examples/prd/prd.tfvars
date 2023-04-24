vcns = {
  "VCN-NAME" = {
    network_cmp                   = "NETWORKING"
    cidrs                         = ["100.01.4.0/23", "100.01.6.0/23", "100.01.16.0/20", "100.01.32.0/20", "100.01.15.0/24"]
    dns_label                     = "ash-test"
    defined_tags                  = { "NAMESPACE.TAG" = "VALUE", "NAMESPACE.TAG" = "VALUE-2" }
    create_internet_gateway       = "true"
    internet_gateway_display_name = "IG-NAME"
  },
  "VCN-NAME-2" = {
    network_cmp                   = "NETWORKING"
    cidrs                         = ["100.02.4.0/23", "100.02.6.0/23", "100.02.16.0/20", "100.02.32.0/20", "100.02.15.0/24"]
    dns_label                     = "ash-test"
    defined_tags                  = { "NAMESPACE.TAG" = "VALUE", "NAMESPACE.TAG" = "VALUE-2" }
    create_internet_gateway       = "true"
    internet_gateway_display_name = "IG-NAME"
  }
}