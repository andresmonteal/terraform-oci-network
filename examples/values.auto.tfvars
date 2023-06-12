tenancy_ocid = "tenant-id"

vcns = {
  "app" = {
    compartment             = "cmp-networking"
    cidrs                   = ["172.31.100.0/23"]
    create_internet_gateway = "true"
    create_nat_gateway      = "true"
    create_service_gateway  = "true"
    drg_name                = "drg-ash"
  }
}