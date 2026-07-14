# == Cloudflare ==

variable "cloudflare_api_token" {
  description = "Cloudflare API token."
  type        = string
  sensitive   = true
}

variable "cloudflare_account_id" {
  description = "Cloudflare Account ID."
  type        = string
}

variable "moe_rangho_zone_id" {
  description = "Cloudflare Zone ID for rangho.moe."
  type        = string
}
