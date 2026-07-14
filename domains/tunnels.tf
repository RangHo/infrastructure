variable "account_id" {
  type = string
}

variable "tunnel_routes_file" {
  type = string
}

locals {
  tunnel_routes = jsondecode(file(var.tunnel_routes_file))
}

resource "cloudflare_zero_trust_tunnel_cloudflared" "hosts" {
  for_each = local.tunnel_routes

  account_id = var.account_id
  name       = "rangho-${each.key}"
  config_src = "cloudflare"
}

resource "cloudflare_zero_trust_tunnel_cloudflared_config" "hosts" {
  for_each = cloudflare_zero_trust_tunnel_cloudflared.hosts

  account_id = var.account_id
  tunnel_id  = each.value.id

  config = {
    ingress = concat(
      [
        for tunnel in local.tunnel_routes[each.key].tunnels : {
          hostname = tunnel.destination
          service  = tunnel.service
        }
      ],
      [{
        service = "http_status:404"
      }]
    )
  }
}
