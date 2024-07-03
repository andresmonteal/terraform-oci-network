# Terraform VCN Module

This Terraform module sets up a Virtual Cloud Network (VCN) along with associated gateways, routes, and other necessary components in a cloud environment.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Usage](#usage)
- [Files](#files)
- [Inputs](#inputs)
- [Outputs](#outputs)
- [Contributing](#contributing)
- [License](#license)

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) 0.12 or later
- Cloud provider account credentials
- Configure Terraform backend

## Usage

To use this module, include the following code in your Terraform configuration:

```hcl
module "vcn" {
  source = "path_to_this_module"

  # Define the necessary variables
  vcn_name   = var.vcn_name
  cidr_block = var.cidr_block
  region     = var.region
  # Add other variables as needed
}

Files
.gitignore: Specifies files and directories to be ignored by git.
datasources.tf: Defines data sources to fetch existing resources.
locals.tf: Defines local variables.
outputs.tf: Defines output values to be exported.
variables.tf: Defines input variables.
vcn.tf: Defines the VCN resource.
vcn_gateways.tf: Defines gateway resources for the VCN.
versions.tf: Specifies the required Terraform version and provider versions.
Example Configuration
The examples/ directory contains a sample configuration to demonstrate how to use the module:

backend.tf: Backend configuration for Terraform state.
main.tf: Main Terraform configuration for setting up the VCN.
provider.tf: Provider configuration.
values.auto.tfvars: Auto-loaded variable values.
variables.tf: Input variables for the example configuration.
Inputs
Name	Description	Type	Default	Required
vcn_name	The name of the VCN	string	n/a	yes
cidr_block	The CIDR block for the VCN	string	n/a	yes
region	The region where the VCN will be created	string	n/a	yes
...	...	...	...	...
Outputs
Name	Description
vcn_id	The ID of the created VCN
vcn_cidr_block	The CIDR block of the created VCN
...	...
Contributing
Contributions are welcome! Please open an issue or submit a pull request for any bugs, feature requests, or enhancements.

License
This project is licensed under the MIT License. See the LICENSE file for details.