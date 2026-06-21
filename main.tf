module "origins" {
  source = "./domains"

  base_domain        = var.domain
  cloudflare_zone_id = var.cloudflare_zone_id
}
