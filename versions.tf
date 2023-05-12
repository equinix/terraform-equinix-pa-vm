terraform {
  required_version = ">= 0.13"
  required_providers {
    equinix = {
      source  = "equinix/equinix"
      version = "~> 1.14"
    }
  }
  provider_meta "equinix" {
    module_name = "equinix-pa-vm"
  }
}
