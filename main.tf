# Cloud VPN
# https://github.com/terraform-google-modules/terraform-google-vpn
module "cloud_vpn" {
  for_each = var.cloud_vpn
  source   = "terraform-google-modules/vpn/google"
  version  = "2.3.1"

  gateway_name              = each.key
  project_id                = lookup(each.value, "project", var.project_id)
  network                   = lookup(each.value, "network")
  region                    = lookup(each.value, "region", var.region)
  tunnel_name_prefix        = lookup(each.value, "tunnel_name_prefix")
  shared_secret             = lookup(each.value, "shared_secret")
  tunnel_count              = lookup(each.value, "tunnel_count", 1)
  peer_ips                  = lookup(each.value, "peer_ips")
  route_priority            = lookup(each.value, "route_priority", 1000)
  remote_subnet             = lookup(each.value, "remote_subnet")
  advertised_route_priority = lookup(each.value, "advertised_route_priority", 100)
  bgp_cr_session_range      = lookup(each.value, "bgp_cr_session_range", ["169.254.1.1/30", "169.254.1.5/30"])
  bgp_remote_session_range  = lookup(each.value, "bgp_remote_session_range", ["169.254.1.2", "169.254.1.6"])
  cr_enabled                = lookup(each.value, "cr_enabled", false)
  cr_name                   = lookup(each.value, "cr_name", "")
  ike_version               = lookup(each.value, "ike_version", 2)
  local_traffic_selector    = lookup(each.value, "local_traffic_selector", ["0.0.0.0/0"])
  peer_asn                  = lookup(each.value, "peer_asn", ["65101"])
  remote_traffic_selector   = lookup(each.value, "remote_traffic_selector", ["0.0.0.0/0"])
  route_tags                = lookup(each.value, "route_tags", [])
  vpn_gw_ip                 = lookup(each.value, "vpn_gw_ip", "")
}

# Cloud VPN HA
# https://github.com/terraform-google-modules/terraform-google-vpn/tree/master/modules/vpn_ha
module "cloud_vpn_ha" {
  for_each = var.cloud_vpn_ha
  source   = "terraform-google-modules/vpn/google//modules/vpn_ha"
  version  = "2.3.1"

  name                    = each.key
  project_id              = lookup(each.value, "project", var.project_id)
  network                 = lookup(each.value, "network")
  region                  = lookup(each.value, "region", var.region)
  create_vpn_gateway      = lookup(each.value, "create_vpn_gateway", true)
  peer_external_gateway   = lookup(each.value, "peer_external_gateway", null)
  peer_gcp_gateway        = lookup(each.value, "peer_gcp_gateway", null)
  route_priority          = lookup(each.value, "route_priority", 1000)
  router_advertise_config = lookup(each.value, "router_advertise_config", null)
  router_asn              = lookup(each.value, "router_asn", 64514)
  router_name             = lookup(each.value, "router_name", "")
  vpn_gateway_self_link   = lookup(each.value, "vpn_gateway_self_link", null)
  tunnels                 = lookup(each.value, "tunnels", {})
}


