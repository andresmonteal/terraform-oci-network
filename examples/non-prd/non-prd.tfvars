vcns = {
  "VCN-NAME" = {
    network_cmp                   = "NETWORKING"
    cidrs                         = ["100.69.4.0/23", "100.69.6.0/23", "100.69.16.0/20", "100.69.32.0/20", "100.69.15.0/24"]
    dns_label                     = "ash-test"
    defined_tags                  = { "NAMESPACE.TAG" = "VALUE", "NAMESPACE.TAG" = "VALUE-2" }
    create_internet_gateway       = "true"
    internet_gateway_display_name = "IG-NAME"
  }
}