
# Copyright (c) 2019, 2021, Oracle Corporation and/or affiliates.

variable "tenancy_ocid" {
  description = "root compartment"
}

variable "environment" {
  default = "pr"
}

variable "region" {
  default = "ash"
}

# subnet parameters

variable "vcns" {
  type = map(any)
}