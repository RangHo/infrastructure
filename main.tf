terraform {
  cloud {
    organization = "rangho"
    workspaces {
      name = "infrastructure"
    }
  }

  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 5"
    }
  }
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

module "domains" {
  source = "./domains"

  account_id         = var.cloudflare_account_id
  moe_rangho_zone_id = var.moe_rangho_zone_id
  tunnel_routes_file = "${path.root}/generated/tunnel-routes.json"
}
