# == General ==

variable "domain" {
  description = "The base domain for which the DNS records will be managed."
  type        = string
}

# == Cloudflare ==

variable "cloudflare_api_token" {
  description = "Cloudflare API token with permissions to manage DNS records."
  type        = string
  sensitive   = true
}

variable "cloudflare_zone_id" {
  description = "The Cloudflare Zone ID for the domain."
  type        = string
}

variable "cloudflare_account_id" {
  description = "The Cloudflare Account ID associated with the domain."
  type        = string
}
