variable "project_id" {
  type = string
}

variable "region" {
  type = string
}

variable "cloud_vpn" {
  description = "Cloud VPN"
  type        = any
  default     = {}
}

variable "cloud_vpn_ha" {
  description = "Cloud VPN HA"
  type        = any
  default     = {}
}