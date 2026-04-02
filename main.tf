terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 5"
    }
    oci = {
      source  = "oracle/oci"
      version = "~> 5"
    }
  }
}
