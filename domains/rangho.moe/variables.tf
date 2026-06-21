variable "base_domain" {
  description = "The base domain for the origin server."
  type        = string
}

variable "cloudflare_zone_id" {
  description = "The Cloudflare zone ID for the domain."
  type        = string
}
