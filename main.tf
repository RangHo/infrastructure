terraform {
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "~> 5"
    }
  }
}

module "cloudflare" {
  source = "./modules/cloudflare"

  api_token  = var.cloudflare_api_token
  domain     = var.domain
  zone_id    = var.cloudflare_zone_id
  account_id = var.cloudflare_account_id
}
