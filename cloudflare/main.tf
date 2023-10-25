terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }
}


provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

module "app-sec" {
  source = "../modules/app-sec"
  cloudflare_zone_id = var.cloudflare_zone_id
  cloudflare_api_token = var.cloudflare_api_token
  cloudflare_email = var.cloudflare_email
}

module "zt-access" {
  source = "../modules/zt-access"
  personal_ip = var.personal_ip
  cloudflare_zone_id = var.cloudflare_zone_id
  cloudflare_api_token = var.cloudflare_api_token
  cloudflare_email = var.cloudflare_email
  cloudflare_account_id = var.cloudflare_account_id
}