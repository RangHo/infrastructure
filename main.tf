module "origins" {
  source = "./origins"

  base_domain        = var.domain
  cloudflare_zone_id = var.cloudflare_zone_id
}

module "cafe-lounge" {
  source = "./machines/cafe-lounge"

  cloudflare_account_id = var.cloudflare_account_id
}
