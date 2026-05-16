variable "base_domain" {
  description = "The base domain for the origin server."
  type        = string
}

variable "cloudflare_zone_id" {
  description = "The Cloudflare zone ID for the domain."
  type        = string
}

resource "cloudflare_dns_record" "origin_yirgacheffe" {
  zone_id = var.cloudflare_zone_id
  name    = "yirgacheffe.origin.${var.base_domain}"
  type    = "A"
  content = "0.0.0.0" # placeholder; will be replaced by DDNS daemon
  proxied = false
  ttl     = 300
}
