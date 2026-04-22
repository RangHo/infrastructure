# Yirgacheffe -- Main homelab origin server.
resource "cloudflare_dns_record" "origin_yirgacheffe" {
  zone_id = var.zone_id
  name    = "yirgacheffe.origin.${var.domain}"
  type    = "A"
  content = "0.0.0.0" # placeholder; will be replaced by DDNS daemon
  proxied = false
  ttl     = 300
}
