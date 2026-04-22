variable "api_token" {
  description = "Cloudflare API token with permissions to manage DNS records."
  type        = string
  sensitive   = true
}

variable "domain" {
  description = "The Cloudflare domain to manage."
  type        = string
}

variable "zone_id" {
  description = "The Cloudflare Zone ID for the domain."
  type        = string
}

variable "account_id" {
  description = "The Cloudflare Account ID associated with the domain."
  type        = string
}
