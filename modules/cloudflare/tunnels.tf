resource "cloudflare_zero_trust_tunnel_cloudflared" "rangho_cafe-lounge" {
  account_id = var.account_id
  name       = "rangho-cafe-lounge"
  config_src = "local"
}
