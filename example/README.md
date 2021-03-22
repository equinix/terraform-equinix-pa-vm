# Equinix Network Edge example: Palo Alto Networks VM series firewall

This example shows how to create redundant Palo Alto Networks VM series firewall
device on Platform Equinix using Equinix PA-VM Terraform module and
Equinix Terraform provider.

In addition to pair of PA-VM devices, following resources are being created
in this example:

* SSH user that is assigned to both devices
* two ACL templates, one for each of the device

The devices are created in Equinix managed mode with license subscription.
Remaining parameters include:

* medium hardware platform (4CPU cores, 8GB of memory)
* VM300 software package
* 100 Mbps of additional internet bandwidth on each device
