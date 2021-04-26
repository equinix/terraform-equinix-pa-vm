provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
}

module "pa-vm" {
  source               = "equinix/pa-vm/equinix"
  version              = "1.0.0"
  name                 = "tf-pa-vm"
  metro_code           = var.metro_code_primary
  platform             = "medium"
  software_package     = "VM300"
  term_length          = 1
  notifications        = ["test@test.com"]
  hostname             = "pavm-pri"
  additional_bandwidth = 100
  acl_template_id      = equinix_network_acl_template.pa-vm-pri.id
  secondary = {
    enabled              = true
    metro_code           = var.metro_code_secondary
    hostname             = "pavm-sec"
    additional_bandwidth = 100
    acl_template_id      = equinix_network_acl_template.pa-vm-sec.id
  }
}

resource "equinix_network_ssh_user" "john" {
  username = "john"
  password = "qwerty123"
  device_ids = [
    module.pa-vm.id,
    module.pa-vm.secondary.id
  ]
}

resource "equinix_network_acl_template" "pa-vm-pri" {
  name        = "tf-pa-vm-pri"
  description = "Primary Palo Alto Networks VM ACL template"
  metro_code  = var.metro_code_primary
  inbound_rule {
    subnets  = ["193.39.0.0/16", "12.16.103.0/24"]
    protocol = "TCP"
    src_port = "any"
    dst_port = "22"
  }
}

resource "equinix_network_acl_template" "pa-vm-sec" {
  name        = "tf-pa-vm-sec"
  description = "Secondary Palo Alto Networks VM ACL template"
  metro_code  = var.metro_code_secondary
  inbound_rule {
    subnets  = ["193.39.0.0/16", "12.16.103.0/24"]
    protocol = "TCP"
    src_port = "any"
    dst_port = "22"
  }
}
