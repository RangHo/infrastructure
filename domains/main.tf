terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 5"
    }
  }
}

variable "moe_rangho_zone_id" {
  type = string
}

module "moe_rangho" {
  source = "./rangho.moe"

  cloudflare_zone_id = var.moe_rangho_zone_id
}
